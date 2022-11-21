//
//  ViewController.swift
//  operators-and-bindings-swift-frameworks
//
//  Created by james.jasenia on 20/11/2022.
//

import UIKit
import Combine

class CombineViewController: CommonViewController {

    let viewModel = CombineViewModel()
    var cancellable = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        viewModel.invokeMockUseCase()
    }
    
    private func setupBindings() {
        viewModel.buttonTitleSubject
            .printToConsole()
            .sink(receiveValue: {
                print("\($0) - from sink")
            }).store(in: &cancellable)
        
        viewModel.buttonTitleSubject
            .assign(to: \.normalTitle, on: styledButton)
            .store(in: &cancellable)
        
        viewModel.isLoadingSubject
            .assign(to: \.isLoading, on: styledButton)
            .store(in: &cancellable)
    }
}


