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
    var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        viewModel.invokeMockLoadingUseCase()
        viewModel.invokeMockNetworkUseCase()
    }
    
    private func setupBindings() {
        viewModel.buttonTitlePublisher
            .printToConsole()
            .sink(receiveValue: {
                print("\($0) - from sink")
            }).store(in: &cancellables)
        
        viewModel.buttonTitlePublisher
            .assign(to: \.normalTitle, on: primaryActionButton)
            .store(in: &cancellables)
        
        viewModel.isLoadingPublisher
            .assign(to: \.isLoading, on: primaryActionButton)
            .store(in: &cancellables)
        
        viewModel.productTitlePublisher
            .map { $0 }
            .assign(to: \.text, on: headerLabel)
            .store(in: &cancellables)
    }
}


