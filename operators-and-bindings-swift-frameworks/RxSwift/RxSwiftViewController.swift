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
        viewModel.invokeMockLoadingUseCase()
        viewModel.invokeMockNetworkUseCase()
    }
    
    private func setupBindings() {
        viewModel.buttonTitleObservable
            .printToConsole()
            .subscribe(onNext: {
                print($0 + " - from subscribe")
            }).disposed(by: disposeBag)
        
        viewModel.buttonTitleObservable
            .bind(to: primaryActionButton.rx.title(for: .normal))
            .disposed(by: disposeBag)
        
        viewModel.isLoadingObservable
            .bind(to: primaryActionButton.rx.isLoading)
            .disposed(by: disposeBag)
        
        viewModel.productTitleObservable
            .bind(to: firstProductLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.loadUseCaseTitleObservable
            .bind(to: secondProductLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
