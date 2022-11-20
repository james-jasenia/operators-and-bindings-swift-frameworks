//
//  RxSwiftViewController.swift
//  operators-and-bindings-swift-frameworks
//
//  Created by james.jasenia on 20/11/2022.
//

import UIKit
import RxSwift
import RxRelay

class RxSwiftViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    let subject = PublishRelay<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBindings()
        subject.accept("RxSwift")
    }
    
    private func setupBindings() {
        subject
            .printToConsole()
            .subscribe(onNext: {
                print($0 + " - from subscribe")
            }).disposed(by: disposeBag)
    }
}

extension ObservableType where Element == String {
    func printToConsole() -> Observable<Element> {
        self.do(onNext: {
            print($0 + " - \(#function)")
        })
    }
}



