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
    
    private let mutableButtonTitleSubject = CurrentValueSubject<String, Never>("Combine")
    var buttonTitlePublisher: AnyPublisher<String, Never> {
        mutableButtonTitleSubject.eraseToAnyPublisher()
    }
    
    private let mutableProducts = CurrentValueSubject<[Product], Never>([])
    var productPublisher: AnyPublisher<String, Never> {
        mutableProducts
            .compactMap { $0.first }
            .map { $0.title }
            .eraseToAnyPublisher()
    }
    
    private let mutableIsLoadingSubject = CurrentValueSubject<Bool, Never>(true)
    var isLoadingPublisher: AnyPublisher<Bool, Never> {
        mutableIsLoadingSubject.eraseToAnyPublisher()
    }
}


//MARK: -- Mock Use Case Behaviour
extension CombineViewModel {
    func invokeMockLoadingUseCase() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: { [weak self] in
            self?.mutableIsLoadingSubject.send(false)
        })
    }
    
    func invokeMockNetworkUseCase() {
        guard let url = URL(string: K.rawProductsURL) else { return }
        
        URLSession.shared
            .dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [ProductResponse].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] products in
                let models = products.map { Product(response: $0) }
                self?.mutableProducts.send(models)
            }.store(in: &cancellables)
    }
}
