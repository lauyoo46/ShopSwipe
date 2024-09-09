//
//  ProductDetailsViewModel.swift
//  ShopSwipe
//
//  Created by Laurentiu Ile on 05.09.2024.
//

import Foundation
import Combine
import RealmSwift

class ProductDetailsViewModel: ObservableObject {
    @Published var product: Product
    @Published var recommendedProducts: [Product] = []
    @Published var productJustAddedToCart: Bool = false
    
    private let numberOfProductsToRecommend = 5
    
    var productSelected = PassthroughSubject<Product, Never>()
    
    init(product: Product) {
        self.product = product
        fetchRecommendedProducts()
    }
    
    func addToCart() {
        showAddToCartMessage()
        if let existingCartItem = getCartItem() {
            RealmStorage.shared.update(existingCartItem) { cartItem in
                cartItem.quantity += 1
            }
        } else {
            RealmStorage.shared.add(CartItem(product: product, quantity: 1))
        }
    }

    private func getCartItem() -> CartItem? {
        let cartItems = RealmStorage.shared.fetch(CartItem.self)
        return cartItems.first(where: { $0.product?.id == product.id })
    }
    
    private func showAddToCartMessage() {
        productJustAddedToCart = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.productJustAddedToCart = false
        }
    }
    
    func fetchRecommendedProducts() {
        recommendedProducts = Array(RealmStorage.shared.fetch(Product.self).shuffled().prefix(numberOfProductsToRecommend))
    }
    
    func selectProduct(_ product: Product) {
        productSelected.send(product)
    }
}
