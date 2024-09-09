//
//  CartViewModel.swift
//  ShopSwipe
//
//  Created by Laurentiu Ile on 05.09.2024.
//

import Foundation
import RealmSwift

class CartViewModel: ObservableObject {
    @Published var cartItems: [CartItem] = []
    
    func loadCartItems() {
        DispatchQueue.main.async {
            self.cartItems = Array(RealmStorage.shared.fetch(CartItem.self))
        }
    }
    
    func increaseQuantity(for item: CartItem) {
        RealmStorage.shared.update(item) { [weak self] updatedItem in
            updatedItem.quantity += 1
            self?.loadCartItems()
        }
    }

    func decreaseQuantity(for item: CartItem) {
        if item.quantity > 1 {
            RealmStorage.shared.update(item) { [weak self] updatedItem in
                updatedItem.quantity -= 1
                self?.loadCartItems()
            }
        } 
    }
}
