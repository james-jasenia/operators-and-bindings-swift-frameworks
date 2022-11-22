//
//  LoadUseCase.swift
//  operators-and-bindings-swift-frameworks
//
//  Created by james.jasenia on 22/11/2022.
//

import Foundation

class LoadUseCase {
    
    //TODO: DI
    let networkService = NetworkService()
    
    func load(for url: URL, completion: @escaping (Result<[Product], Error>) -> Void) {
        networkService.invokeNetworkService(for: url, completion: completion)
    }
}
