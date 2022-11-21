//
//  RxSwiftViewController.swift
//  operators-and-bindings-swift-frameworks
//
//  Created by james.jasenia on 20/11/2022.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa

class RxSwiftViewController: CommonViewController {
    
    let disposeBag = DisposeBag()
    let buttonTitleRelay = PublishRelay<String>()
    let isLoadingRelay = BehaviorRelay<Bool>(value: true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        buttonTitleRelay.accept("RxSwift")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: { [weak self] in
            self?.isLoadingRelay.accept(false)
        })
    }
    
    private func setupBindings() {
        buttonTitleRelay
            .printToConsole()
            .subscribe(onNext: {
                print($0 + " - from subscribe")
            }).disposed(by: disposeBag)
        
        buttonTitleRelay
            .bind(to: styledButton.rx.title(for: .normal))
            .disposed(by: disposeBag)
        
        isLoadingRelay
            .bind(to: styledButton.rx.isLoading)
            .disposed(by: disposeBag)
    }
}

