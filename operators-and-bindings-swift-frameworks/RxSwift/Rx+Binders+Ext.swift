//
//  Rx+Binders+Ext.swift
//  operators-and-bindings-swift-frameworks
//
//  Created by james.jasenia on 20/11/2022.
//

import Foundation
import RxSwift

extension Reactive where Base: StyledButton {
    var isLoading: Binder<Bool> {
        return Binder(self.base) { button, isLoading in
            button.isLoadingIndicatorEnabled(isLoading)
        }
    }
}
