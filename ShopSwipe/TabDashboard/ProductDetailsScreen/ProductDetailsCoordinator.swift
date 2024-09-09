//
//  ProductDetailsCoordinator.swift
//  ShopSwipe
//
//  Created by Laurentiu Ile on 05.09.2024.
//

import Combine
import UIKit
import SwiftUI

class ProductDetailsCoordinator: Coordinator {
    let navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var isCompleted: (() -> ())?
    
    var viewModel: ProductDetailsViewModel
    var viewController: UIViewController
    private var subscriptions = Set<AnyCancellable>()
    
    init(navigationController: UINavigationController, product: Product) {
        self.navigationController = navigationController
        navigationController.navigationBar.isHidden = false
        
        viewModel = ProductDetailsViewModel(product: product)
        let view = ProductDetailsView().environmentObject(viewModel)
        viewController = UIHostingController(rootView: view)
    }
    
    func start() {
        configureNavBar()
        
        viewModel.productSelected
            .sink { [weak self] selectedProduct in
                self?.showProductDetails(product: selectedProduct)
            }
            .store(in: &subscriptions)
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func showProductDetails(product: Product) {
        let productDetailsCoordinator = ProductDetailsCoordinator(navigationController: navigationController, product: product)
        store(coordinator: productDetailsCoordinator)
        productDetailsCoordinator.start()
        productDetailsCoordinator.isCompleted = { [weak self] in
            self?.free(coordinator: productDetailsCoordinator)
        }
    }
    
    private func configureNavBar() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(backToProductList))
        backButton.tintColor = .blue
        
        viewController.navigationItem.hidesBackButton = true
        viewController.navigationItem.setLeftBarButton(backButton, animated: false)
    }
    
    @objc private func backToProductList() {
        isCompleted?()
        navigationController.popViewController(animated: true)
    }
}
