//
//  AppCoordinator.swift
//  ShopSwipe
//
//  Created by Laurentiu Ile on 05.09.2024.
//

import Foundation
import UIKit
import SwiftUI

class AppCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var isCompleted: (() -> ())?
    
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let tabBarCoordinator = TabBarCoordinator()
        store(coordinator: tabBarCoordinator)
        tabBarCoordinator.start()
        
        tabBarCoordinator.isCompleted = { [weak self ] in
            self?.free(coordinator: tabBarCoordinator)
        }
        window.rootViewController = tabBarCoordinator.rootViewController
    }
}
