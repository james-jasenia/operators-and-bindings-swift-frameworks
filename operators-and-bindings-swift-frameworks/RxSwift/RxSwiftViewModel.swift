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
    let disposeBag = DisposeBag()
    
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
}

//MARK: -- Mock Use Case Behaviour
extension RxSwiftViewModel {

    func invokeMockLoadingUseCase() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: { [weak self] in
            self?.mutableIsLoadingRelay.accept(false)
        })
    }
    
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
