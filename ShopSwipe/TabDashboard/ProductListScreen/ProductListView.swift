//
//  ProductListView.swift
//  ShopSwipe
//
//  Created by Laurentiu Ile on 05.09.2024.
//

import SwiftUI

struct ProductListView: View {
    @EnvironmentObject var viewModel: ProductListViewModel
    
    var body: some View {
        Text("Product List")
            .font(.largeTitle)
            .bold()
            .padding(.top, 20)
        
        List(viewModel.products) { product in
            HStack {
                AsyncImage(url: URL(string: product.image)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                    case .failure:
                        Image(systemName: "photo")
                    @unknown default:
                        Image(systemName: "photo")
                    }
                }
                
                VStack(alignment: .leading) {
                    Text(product.title)
                        .font(.headline)
                    Text(String(format: "$%.2f", product.price))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            .padding(.vertical, 16)
            .onTapGesture {
                viewModel.goToDetails(product: product)
            }
        }
        .onAppear {
            viewModel.loadProducts(limit: 20)
            viewModel.hideNavigationBar()
        }
    }
}

#Preview {
    ProductListView()
}
