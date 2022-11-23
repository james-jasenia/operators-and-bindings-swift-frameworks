//
//  ReactiveSwiftViewModel.swift
//  operators-and-bindings-swift-frameworks
//
//  Created by james.jasenia on 21/11/2022.
//

import Foundation
import ReactiveSwift

class ReactiveSwiftViewModel {
    
    let useCase = LoadUseCase()
    let disposables = CompositeDisposable()
    
    private let mutableProductsProperty = MutableProperty<[Product]>([])
    var productTitleProducer: SignalProducer<String, Never> {
        mutableProductsProperty
            .producer
            .compactMap { $0.first }
            .map { $0.title }
    }
    
    private let mutableButtonTitleProperty = MutableProperty<String>("Reactive Swift")
    var buttonTitleProducer: SignalProducer<String, Never> {
        mutableButtonTitleProperty.producer
    }
    
    private let mutableIsLoadingProperty = MutableProperty<Bool>(true)
    var isLoadingProducer: SignalProducer<Bool, Never> {
        mutableIsLoadingProperty.producer
    }
    
    var loadUseCaseTitleObservable: SignalProducer<String, Never> {
        return constructDeferredLoadObservableWithFallbackUrl()
            .flatMapError { _ in SignalProducer(value: "") }
    }
}

//MARK: -- Mock Use Case Behaviour
extension ReactiveSwiftViewModel {
    
    func invokeMockLoadingUseCase() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: { [weak self] in
            self?.mutableIsLoadingProperty.swap(false)
        })
    }
    
    func invokeMockNetworkUseCase() {
        guard let url = URL(string: K.rawProductsPrimaryUrl) else { return }
        
        let request = URLRequest(url: url)
        
        disposables += URLSession.shared
            .reactive
            .data(with: request)
            .attemptMap { (data, response) in
                try JSONDecoder().decode([ProductResponse].self, from: data)
            }.map {
                $0.map { Product(response: $0) }
            }
            .observe(on: UIScheduler())
            .startWithResult { [weak self] result in
                switch result {
                case let .success(products):
                    self?.mutableProductsProperty.swap(products)
                case .failure:
                    break
                }
            }
    }
    
    func constructDeferredLoadObservableWithFallbackUrl() -> SignalProducer<String, Error> {
        let primaryUrl = URL(string: K.rawProductsBrokenPrimaryUrl)!
        let fallbackUrl = URL(string: K.rawProductsFallbackUrl)!
        
        let fallback = useCase.loadSignal(for: fallbackUrl)
        
        return useCase.loadSignal(for: primaryUrl)
            .fallback(to: { _ in fallback } )
            .observe(on: UIScheduler())
            .compactMap { $0.first }
            .map { $0.title }
            .producer
    }
}
