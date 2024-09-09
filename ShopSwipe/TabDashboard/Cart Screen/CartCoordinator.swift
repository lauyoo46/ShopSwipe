//
//  CartCoordinator.swift
//  ShopSwipe
//
//  Created by Laurentiu Ile on 05.09.2024.
//

import UIKit
import SwiftUI

class CartCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var isCompleted: (() -> ())?
    
    var viewModel: CartViewModel
    var viewController: UIViewController
    
    init() {
        navigationController = UINavigationController()
        navigationController.navigationBar.isHidden = true
        navigationController.navigationBar.prefersLargeTitles = true
        viewModel = CartViewModel()
        let view = CartView().environmentObject(viewModel)
        viewController = UIHostingController(rootView: view)
    }
    
    func start() {
        navigationController.setViewControllers([viewController], animated: false)
    }
}
