//
//  Coordinator.swift
//  ShopSwipe
//
//  Created by Laurentiu Ile on 05.09.2024.
//

import Foundation
import UIKit
import SwiftUI

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var isCompleted: (() -> ())? { get set }
    func start()
}

extension Coordinator {
    func store(coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    func free(coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}
