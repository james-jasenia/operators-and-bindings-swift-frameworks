//
//  ReactiveSwiftViewController.swift
//  operators-and-bindings-swift-frameworks
//
//  Created by james.jasenia on 20/11/2022.
//

import UIKit
import ReactiveSwift

class ReactiveSwiftViewController: CommonViewController {
    
    let disposables = CompositeDisposable()
    let publisher = MutableProperty<String>("")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        publisher.swap("Reactive Swift")
    }
    
    private func setupBindings() {
        disposables += publisher.signal
            .printToConsole()
            .observeValues {
                print($0 + " - from observeValues")
            }
    }
}
