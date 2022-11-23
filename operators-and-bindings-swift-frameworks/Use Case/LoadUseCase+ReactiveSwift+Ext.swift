//
//  LoadUseCase+ReactiveSwift+Ext.swift
//  operators-and-bindings-swift-frameworks
//
//  Created by james.jasenia on 22/11/2022.
//

import Foundation
import ReactiveSwift

extension LoadUseCase {
    func loadSignal(for url: URL) -> SignalProducer<[Product], Error> {
        return SignalProducer { (observer, disposable) in
            self.load(for: url) { result in
                switch result {
                case let .success(product):
                    observer.send(value: product)
                case let .failure(error):
                    observer.send(error: error)
                }
                observer.sendCompleted()
            }
        }
    }
}

extension SignalProducer {
    func fallback(to producer: @escaping (Error) -> SignalProducer<Value, Error>) -> SignalProducer<Value, Error> {
        self.flatMapError(producer)
    }
}
