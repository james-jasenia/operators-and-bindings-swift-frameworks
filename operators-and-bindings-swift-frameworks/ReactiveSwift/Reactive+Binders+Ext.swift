//
//  Reactive+Binders+Ext.swift
//  operators-and-bindings-swift-frameworks
//
//  Created by james.jasenia on 21/11/2022.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa

extension Reactive where Base == StyledButton {
    var isLoading: BindingTarget<Bool> {
        return makeBindingTarget { button, isLoading in
            button.isLoadingIndicatorEnabled(isLoading)
        }
    }
}
