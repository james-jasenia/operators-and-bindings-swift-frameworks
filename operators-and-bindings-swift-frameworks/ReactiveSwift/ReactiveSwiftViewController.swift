//
//  ReactiveSwiftViewController.swift
//  operators-and-bindings-swift-frameworks
//
//  Created by james.jasenia on 20/11/2022.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa

class ReactiveSwiftViewController: CommonViewController {
    
    let disposables = CompositeDisposable()
    let buttonTitlePublisher = MutableProperty<String>("")
    let isLoadingPublisher = MutableProperty<Bool>(true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        buttonTitlePublisher.swap("Reactive Swift")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: { [weak self] in
            self?.isLoadingPublisher.swap(false)
        })
    }
    
    private func setupBindings() {
        disposables += buttonTitlePublisher.signal
            .printToConsole()
            .observeValues {
                print($0 + " - from observeValues")
            }
        
        styledButton.reactive.title <~ buttonTitlePublisher
        styledButton.reactive.isLoading <~ isLoadingPublisher
    }
}
