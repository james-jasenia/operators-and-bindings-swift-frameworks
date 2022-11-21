//
//  CombineViewModel.swift
//  operators-and-bindings-swift-frameworks
//
//  Created by james.jasenia on 21/11/2022.
//

import Combine
import Foundation

class CombineViewModel {
    
    private let mutableButtonTitleSubject = CurrentValueSubject<String, Never>("Combine")
    var buttonTitleSubject: AnyPublisher<String, Never> {
        mutableButtonTitleSubject.eraseToAnyPublisher()
    }
    
    private let mutableIsLoadingSubject = CurrentValueSubject<Bool, Never>(true)
    var isLoadingSubject: AnyPublisher<Bool, Never> {
        mutableIsLoadingSubject.eraseToAnyPublisher()
    }
    
    func invokeMockUseCase() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: { [weak self] in
            self?.mutableIsLoadingSubject.send(false)
        })
    }
}
