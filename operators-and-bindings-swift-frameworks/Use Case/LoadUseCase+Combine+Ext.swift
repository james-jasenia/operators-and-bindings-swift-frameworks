//
//  LoadUseCase+Ext.swift
//  operators-and-bindings-swift-frameworks
//
//  Created by james.jasenia on 22/11/2022.
//

import Foundation
import Combine

extension LoadUseCase {
    func loadPublisher(for url: URL) -> AnyPublisher<[Product], Error> {
        Deferred {
            Future { promise in
                self.load(for: url, completion: promise)
            }
        }
        .eraseToAnyPublisher()
    }
}

extension Publisher {
    func fallback(to fallbackPublisher: @escaping (Error) -> AnyPublisher<Output, Failure>) -> AnyPublisher<Output, Failure> {
        
        // Catch is designed to handle fallback logic in case of an error.
        self.catch(fallbackPublisher).eraseToAnyPublisher()
    }
}
