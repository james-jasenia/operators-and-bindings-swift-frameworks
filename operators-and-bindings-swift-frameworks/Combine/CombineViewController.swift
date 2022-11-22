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
        viewModel.invokeNetworkRequestUsingDataTaskPublisher()
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
        
        viewModel.isLoadingMockedPublisher
            .assign(to: \.isLoading, on: primaryActionButton)
            .store(in: &cancellables)
        
        viewModel.productTitleDataTaskPublisher
            .map { $0 }
            .assign(to: \.text, on: firstProductLabel)
            .store(in: &cancellables)
        
        viewModel.loadUseCaseTitlePublisher
            .map { $0 }
            .assign(to: \.text, on: secondProductLabel)
            .store(in: &cancellables)
    }
}


