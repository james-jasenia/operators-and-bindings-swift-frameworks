//
//  ReactiveSwiftViewModel.swift
//  operators-and-bindings-swift-frameworks
//
//  Created by james.jasenia on 21/11/2022.
//

import Foundation
import ReactiveSwift

class ReactiveSwiftViewModel {
    private let mutableButtonTitleProperty = MutableProperty<String>("Reactive Swift")
    var buttonTitleProducer: SignalProducer<String, Never> {
        mutableButtonTitleProperty.producer
    }
    
    private let mutableIsLoadingProperty = MutableProperty<Bool>(true)
    var isLoadingProducer: SignalProducer<Bool, Never> {
        mutableIsLoadingProperty.producer
    }
    
    func invokeMockUseCase() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: { [weak self] in
            self?.mutableIsLoadingProperty.swap(false)
        })
    }
}
