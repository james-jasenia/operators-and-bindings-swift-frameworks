//
//  ViewController.swift
//  operators-and-bindings-swift-frameworks
//
//  Created by james.jasenia on 20/11/2022.
//

import UIKit
import Combine

class CombineViewController: UIViewController {

    var cancellable = Set<AnyCancellable>()
    let publisher = PassthroughSubject<String, Never>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBindings()
        publisher.send("Combine")
    }
    
    private func setupBindings() {
        publisher
            .printToConsole()
            .sink(receiveValue: {
                print("\($0) - from sink")
            }).store(in: &cancellable)
    }
}

extension Publisher where Output == String {
    func printToConsole() -> AnyPublisher<Output, Failure> {
        handleEvents(receiveOutput: { value in
            Swift.print(value + " - \(#function)")
        }).eraseToAnyPublisher()
    }
}
