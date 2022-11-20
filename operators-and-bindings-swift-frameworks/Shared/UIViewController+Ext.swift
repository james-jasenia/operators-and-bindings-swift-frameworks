//
//  UIViewController+Ext.swift
//  operators-and-bindings-swift-frameworks
//
//  Created by james.jasenia on 20/11/2022.
//

import UIKit

extension UIViewController {
    func setupView() {
        view.backgroundColor = .white
    }
    
    func addView(_ anyView: UIView) {
        anyView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(anyView)
        
        anyView.layer.cornerRadius = 30
        
        NSLayoutConstraint.activate([
            anyView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            anyView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            anyView.heightAnchor.constraint(equalToConstant: 60),
            anyView.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
}
