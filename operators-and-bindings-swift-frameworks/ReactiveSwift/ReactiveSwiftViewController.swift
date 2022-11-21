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
    let viewModel = ReactiveSwiftViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        viewModel.invokeMockUseCase()
    }
    
    private func setupBindings() {
        disposables += viewModel.buttonTitleProducer
            .printToConsole()
            .startWithValues {
                print($0 + " - from observeValues")
            }
        
        styledButton.reactive.title <~ viewModel.buttonTitleProducer
        styledButton.reactive.isLoading <~ viewModel.isLoadingProducer
    }
}
