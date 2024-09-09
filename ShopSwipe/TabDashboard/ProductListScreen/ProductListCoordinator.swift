//
//  ProductListCoordinator.swift
//  ShopSwipe
//
//  Created by Laurentiu Ile on 05.09.2024.
//

import Combine
import UIKit
import SwiftUI

class ProductListCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var isCompleted: (() -> ())?
    
    var viewModel: ProductListViewModel
    var viewController: UIViewController
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        navigationController = UINavigationController()
        navigationController.navigationBar.isHidden = true
        navigationController.navigationBar.prefersLargeTitles = true
        viewModel = ProductListViewModel()
        let view = ProductListView().environmentObject(viewModel)
        viewController = UIHostingController(rootView: view)
    }
    
    func start() {
        viewModel.delegate = self
        
        viewModel.hideNavBar
            .sink { [weak self] in
                self?.navigationController.navigationBar.isHidden = true
            }
            .store(in: &subscriptions)
        
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    private func showProductDetails(product: Product) {
        let productDetailsCoordinator = ProductDetailsCoordinator(navigationController: navigationController, product: product)
        store(coordinator: productDetailsCoordinator)
        productDetailsCoordinator.start()
        productDetailsCoordinator.isCompleted = { [weak self] in
            self?.free(coordinator: productDetailsCoordinator)
        }
    }
}

extension ProductListCoordinator: ProductListViewModelDelegate {
    func showProductDetailsScreen(product: Product) {
        showProductDetails(product: product)
    }
}
