//
//  AppComposer.swift
//  operators-and-bindings-swift-frameworks
//
//  Created by james.jasenia on 20/11/2022.
//

import Foundation
import UIKit

struct AppComposer {
    static func composeRootViewController() -> UITabBarController {
        let tabBarController = UITabBarController()
        
        let combineViewController = CombineViewController()
        let combineNaigationController = UINavigationController(rootViewController: combineViewController)
        combineViewController.title = "Combine"
        combineNaigationController.tabBarItem = UITabBarItem(title: "Combine", image: nil, selectedImage: nil)
        
        let rxSwiftViewController = RxSwiftViewController()
        let rxSwiftNaigationController = UINavigationController(rootViewController: rxSwiftViewController)
        rxSwiftViewController.title = "RxSwift"
        rxSwiftNaigationController.tabBarItem = UITabBarItem(title: "Rx", image: nil, selectedImage: nil)
        
        let reactiveSwiftViewController = ReactiveSwiftViewController()
        let reactiveSwiftNaigationController = UINavigationController(rootViewController: reactiveSwiftViewController)
        reactiveSwiftViewController.title = "Reactive Swift"
        reactiveSwiftNaigationController.tabBarItem = UITabBarItem(title: "Reactive", image: nil, selectedImage: nil)
        
        let rootViewControllers = [
            combineNaigationController,
            rxSwiftNaigationController,
            reactiveSwiftNaigationController
        ]
        
        tabBarController.viewControllers = rootViewControllers
        
        return tabBarController
    }
}
