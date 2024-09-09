//
//  ProductListView.swift
//  ShopSwipe
//
//  Created by Laurentiu Ile on 05.09.2024.
//

import Foundation
import Combine

protocol ProductListViewModelDelegate: AnyObject {
    func showProductDetailsScreen(product: Product)
}

class ProductListViewModel: ObservableObject {
    
    private let networkService: NetworkService
    weak var delegate: ProductListViewModelDelegate?
    
    @Published var products: [Product] = []
    
    var hideNavBar = PassthroughSubject<Void, Never>()
    
    init(networkService: NetworkService = NetworkManager.shared) {
        self.networkService = networkService
    }
    
    func loadProducts(limit: Int) {
        networkService.fetchProducts(limit: limit) { result in
            switch result {
            case .success(let products):
                DispatchQueue.main.async {
                    self.products = products
                    RealmStorage.shared.add(products, update: .modified)
                }
                
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func goToDetails(product: Product) {
        delegate?.showProductDetailsScreen(product: product)
    }
    
    func hideNavigationBar() {
        hideNavBar.send()
    }
}
