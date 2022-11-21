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
    private let mutableButtonTitleRelay = BehaviorRelay<String>(value: "RxSwift")
    var buttonTitleRelay: Observable<String> {
        mutableButtonTitleRelay.asObservable()
    }
    
    private let mutableIsLoadingRelay = BehaviorRelay<Bool>(value: true)
    var isLoadingRelay: Observable<Bool> {
        mutableIsLoadingRelay.asObservable()
    }
    
    func invokeMockUseCase() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: { [weak self] in
            self?.mutableIsLoadingRelay.accept(false)
        })
    }
}
