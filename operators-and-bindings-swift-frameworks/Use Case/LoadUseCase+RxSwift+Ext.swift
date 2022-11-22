//
//  LoadUseCase+RxSwift+Ext.swift
//  operators-and-bindings-swift-frameworks
//
//  Created by james.jasenia on 22/11/2022.
//

import Foundation
import RxSwift

extension LoadUseCase {
    func loadObservable(for url: URL) -> Observable<[Product]> {
        return Single.create { completion in
            self.load(for: url, completion: completion)
            return Disposables.create { }
        }.asObservable()
    }
}

// Lack of type constraints means that you need to use a generic Observable<Element> as a parameter and a return type.
extension Observable {
    func fallback(to observable: @escaping (Error) throws -> Observable<Element>) -> Observable<Element> {
        self.catch(observable).asObservable()
    }
}
