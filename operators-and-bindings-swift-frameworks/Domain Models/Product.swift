//
//  Product.swift
//  operators-and-bindings-swift-frameworks
//
//  Created by james.jasenia on 22/11/2022.
//

import Foundation

struct Product {
    let title: String
}

extension Product {
    init(response: ProductResponse) {
        self.title = response.title
    }
}

