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
    let publisher = PassthroughSubject<String, Never>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addView(styledButton)
        setupBindings()
        publisher.send("Combine")
    }
    
    private func setupBindings() {
        publisher
            .printToConsole()
            .sink(receiveValue: {
                print("\($0) - from sink")
            }).store(in: &cancellable)
        
        publisher
            .assign(to: \.normalTitle, on: styledButton)
            .store(in: &cancellable)
    }
}


