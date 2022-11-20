//
//  CommonViewController.swift
//  operators-and-bindings-swift-frameworks
//
//  Created by james.jasenia on 20/11/2022.
//

import UIKit

class CommonViewController: UIViewController {
    
    lazy var styledButton: StyledButton = {
        let button = StyledButton()
        button.setTitle("Button", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addView(styledButton)
    }
}
