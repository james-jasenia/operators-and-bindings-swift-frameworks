//
//  RxSwiftViewModel.swift
//  operators-and-bindings-swift-frameworks
//
//  Created by james.jasenia on 21/11/2022.
//

import Foundation
import RxSwift
import RxCocoa

class RxSwiftViewModel {
    
    private let loadUseCase = LoadUseCase()
    private let disposeBag = DisposeBag()
        
    private let mutableButtonTitleRelay = BehaviorRelay<String>(value: "RxSwift")
    var buttonTitleObservable: Observable<String> {
        mutableButtonTitleRelay.asObservable()
    }
    
    private let mutableIsLoadingRelay = BehaviorRelay<Bool>(value: true)
    var isLoadingObservable: Observable<Bool> {
        mutableIsLoadingRelay.asObservable()
    }
    
    private let mutableProductsRelay = BehaviorRelay<[Product]>(value: [])
    var productTitleObservable: Observable<String> {
        mutableProductsRelay
            .compactMap { $0.first }
            .map { $0.title }
            .asObservable()
    }
    
    var loadUseCaseTitleObservable: Observable<String> {
        return constructDeferredLoadObservableWithFallbackUrl()
    }
}

//MARK: -- Mocked isLoading
extension RxSwiftViewModel {
    
    func invokeMockLoadingUseCase() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: { [weak self] in
            self?.mutableIsLoadingRelay.accept(false)
        })
    }
}

//MARK: -- Data Request Observable
extension RxSwiftViewModel {
    
    func invokeMockNetworkUseCase() {
        guard let url = URL(string: K.rawProductsPrimaryUrl) else { return }
        
        let request = URLRequest(url: url)
        
        URLSession.shared
            .rx
            .data(request: request)
            .decode(type: [ProductResponse].self, decoder: JSONDecoder())
            .mapMany { Product(response: $0) }
            .bind(to: mutableProductsRelay)
            .disposed(by: disposeBag)
    }
}
    
//MARK: -- Load Use Case Behaviour
extension RxSwiftViewModel {
    
    func constructDeferredLoadObservableWithFallbackUrl() -> Observable<String> {
        guard let primaryUrl = URL(string: K.rawProductsBrokenPrimaryUrl) else { fatalError("Developer error") }
        guard let fallbackUrl = URL(string: K.rawProductsFallbackUrl) else { fatalError("Developer error") }
        
        let fallbackObservable = loadUseCase.loadObservable(for: fallbackUrl)
        
        return loadUseCase.loadObservable(for: primaryUrl)
            .fallback { _ in  fallbackObservable }
            .observe(on: MainScheduler.instance)
            .compactMap { $0.first }
            .map { $0.title }
    }
}
