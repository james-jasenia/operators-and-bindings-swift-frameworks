//
//  CommonViewController.swift
//  operators-and-bindings-swift-frameworks
//
//  Created by james.jasenia on 20/11/2022.
//

import UIKit

class CommonViewController: UIViewController {
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 15
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var firstProductLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }()
    
    lazy var secondProductLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }()
    
    lazy var primaryActionButton: StyledButton = {
        let button = StyledButton()
        button.setTitle("Button", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        view.backgroundColor = .white
        stackView.translatesAutoresizingMaskIntoConstraints = false
        primaryActionButton.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)
        
        stackView.addArrangedSubview(firstProductLabel)
        stackView.addArrangedSubview(secondProductLabel)
        stackView.addArrangedSubview(primaryActionButton)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            primaryActionButton.heightAnchor.constraint(equalToConstant: 60),
        ])
        
        primaryActionButton.layer.cornerRadius = 30
    }
}
