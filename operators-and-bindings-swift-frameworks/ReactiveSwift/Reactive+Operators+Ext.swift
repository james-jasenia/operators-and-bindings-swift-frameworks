//
//  Reactive+Operators+Ext.swift
//  operators-and-bindings-swift-frameworks
//
//  Created by james.jasenia on 20/11/2022.
//

import Foundation
import ReactiveSwift

extension SignalProducer where Value == String, Error == Never {
    func printToConsole() -> SignalProducer<String, Never> {
        on(value: {
            print($0 + " - \(#function)")
        })
    }
}

