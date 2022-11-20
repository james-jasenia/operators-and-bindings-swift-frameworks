//
//  Rx+Operators+Ext.swift
//  operators-and-bindings-swift-frameworks
//
//  Created by james.jasenia on 20/11/2022.
//

import Foundation
import RxSwift

extension ObservableType where Element == String {
    func printToConsole() -> Observable<Element> {
        self.do(onNext: {
            print($0 + " - \(#function)")
        })
    }
}

