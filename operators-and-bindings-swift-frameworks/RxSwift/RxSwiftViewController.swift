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
    let viewModel = RxSwiftViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        viewModel.invokeMockUseCase()
    }
    
    private func setupBindings() {
        viewModel.buttonTitleRelay
            .printToConsole()
            .subscribe(onNext: {
                print($0 + " - from subscribe")
            }).disposed(by: disposeBag)
        
        viewModel.buttonTitleRelay
            .bind(to: primaryActionButton.rx.title(for: .normal))
            .disposed(by: disposeBag)
        
        viewModel.isLoadingRelay
            .bind(to: primaryActionButton.rx.isLoading)
            .disposed(by: disposeBag)
    }
}

