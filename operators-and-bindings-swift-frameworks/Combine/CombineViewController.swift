//
//  ViewController.swift
//  operators-and-bindings-swift-frameworks
//
//  Created by james.jasenia on 20/11/2022.
//

import UIKit
import Combine

class CombineViewController: CommonViewController {

    var cancellable = Set<AnyCancellable>()
    let buttonTitleSubject = PassthroughSubject<String, Never>()
    let isLoadingSubject = CurrentValueSubject<Bool, Never>(true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addView(styledButton)
        setupBindings()
        buttonTitleSubject.send("Combine")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: { [weak self] in
            self?.isLoadingSubject.send(false)
        })

    }
    
    private func setupBindings() {
        buttonTitleSubject
            .printToConsole()
            .sink(receiveValue: {
                print("\($0) - from sink")
            }).store(in: &cancellable)
        
        buttonTitleSubject
            .assign(to: \.normalTitle, on: styledButton)
            .store(in: &cancellable)
        
        isLoadingSubject
            .assign(to: \.isLoading, on: styledButton)
            .store(in: &cancellable)
    }
}


