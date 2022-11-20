//
//  Combine+Operators+Ext.swift
//  operators-and-bindings-swift-frameworks
//
//  Created by james.jasenia on 20/11/2022.
//

import Foundation
import Combine

extension Publisher where Output == String {
    func printToConsole() -> AnyPublisher<Output, Failure> {
        handleEvents(receiveOutput: { value in
            Swift.print(value + " - \(#function)")
        }).eraseToAnyPublisher()
    }
}
