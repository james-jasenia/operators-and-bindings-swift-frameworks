//
//  CombineViewModel.swift
//  operators-and-bindings-swift-frameworks
//
//  Created by james.jasenia on 21/11/2022.
//

import Combine
import Foundation

class CombineViewModel {
    
    var cancellables = Set<AnyCancellable>()
    let loadUseCase = LoadUseCase()
    
    private let mutableButtonTitleSubject = CurrentValueSubject<String, Never>("Combine")
    var buttonTitlePublisher: AnyPublisher<String, Never> {
        mutableButtonTitleSubject.eraseToAnyPublisher()
    }
    
    private let mutableProductsDataTaskPublisherSubject = CurrentValueSubject<[Product], Never>([])
    var productTitleDataTaskPublisher: AnyPublisher<String, Never> {
        mutableProductsDataTaskPublisherSubject
            .compactMap { $0.first }
            .map { $0.title }
            .eraseToAnyPublisher()
    }
    
    private let mutableMockedIsLoadingSubject = CurrentValueSubject<Bool, Never>(true)
    var isLoadingMockedPublisher: AnyPublisher<Bool, Never> {
        mutableMockedIsLoadingSubject.eraseToAnyPublisher()
    }
    
    var loadUseCaseTitlePublisher: AnyPublisher<String, Never > {
        return constructDeferredLoadPublisherWithFallbackUrl()
    }
}

//MARK: -- Mocked isLoading
extension CombineViewModel {
    func invokeMockLoadingUseCase() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: { [weak self] in
            self?.mutableMockedIsLoadingSubject.send(false)
        })
    }
}

//MARK: -- Data Task Publisher
extension CombineViewModel {
    
    func invokeNetworkRequestUsingDataTaskPublisher() {
        guard let url = URL(string: K.rawProductsPrimaryUrl) else { return }
        
        URLSession.shared
            .dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [ProductResponse].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { _ in
                return
            } receiveValue: { [weak self] products in
                let models = products.map { Product(response: $0) }
                self?.mutableProductsDataTaskPublisherSubject.send(models)
            }.store(in: &cancellables)
    }
}

//MARK: -- Load Use Case Behaviour
extension CombineViewModel {
    func constructDeferredLoadPublisherWithFallbackUrl() -> AnyPublisher<String, Never> {
        guard let primaryUrl = URL(string: K.rawProductsBrokenPrimaryUrl) else { fatalError("Developer error") }
        guard let fallbackUrl = URL(string: K.rawProductsFallbackUrl) else { fatalError("Developer error") }
        
        let fallbackPublisher = loadUseCase.loadPublisher(for: fallbackUrl)
        
        return loadUseCase
            .loadPublisher(for: primaryUrl)
            .fallback(to: { _ in fallbackPublisher })
            .receive(on: DispatchQueue.main)
            .replaceError(with: [])
            .compactMap { $0.first }
            .map { $0.title }
            .eraseToAnyPublisher()
    }
}
