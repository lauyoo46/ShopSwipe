//
//  TabBarCoordinator.swift
//  ShopSwipe
//
//  Created by Laurentiu Ile on 05.09.2024.
//

import Foundation
import SwiftUI
import UIKit

class TabBarCoordinator: Coordinator {
    var rootViewController: UITabBarController
    var childCoordinators: [Coordinator] = []
    var isCompleted: (() -> ())?
    
    init() {
        self.rootViewController = UITabBarController()
        rootViewController.tabBar.isTranslucent = true
        rootViewController.tabBar.backgroundColor = .lightGray
    }
    
    func start() {
        let productListCoordinator = ProductListCoordinator()
        productListCoordinator.start()
        store(coordinator: productListCoordinator)
        productListCoordinator.isCompleted = { [weak self] in
            self?.free(coordinator: productListCoordinator)
        }
        let productListViewController = productListCoordinator.navigationController
        setupTabBarItem(viewController: productListViewController,
                        title: "Product List",
                        imageName: "rectangle.stack",
                        selectedImageName: "rectangle.stack.fill")
        
        let cartCoordinator = CartCoordinator()
        cartCoordinator.start()
        cartCoordinator.isCompleted = { [weak self] in
            self?.free(coordinator: cartCoordinator)
        }
        store(coordinator: cartCoordinator)
        let cartViewController = cartCoordinator.navigationController
        setupTabBarItem(viewController: cartViewController,
                        title: "Cart",
                        imageName: "cart",
                        selectedImageName: "cart.fill")
        
        rootViewController.viewControllers = [productListViewController, cartViewController]
    }
    
    private func setupTabBarItem(viewController: UIViewController, title: String, imageName: String, selectedImageName: String) {
        let defaultImage = UIImage(systemName: imageName)
        let selectedImage = UIImage(systemName: selectedImageName)
        let tabBarItem = UITabBarItem(title: title, image: defaultImage, selectedImage: selectedImage)
        viewController.tabBarItem = tabBarItem
    }
}
