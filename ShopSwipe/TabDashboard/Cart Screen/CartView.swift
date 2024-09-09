//
//  CartView.swift
//  ShopSwipe
//
//  Created by Laurentiu Ile on 05.09.2024.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var viewModel: CartViewModel
    
    var body: some View {
        Text("My cart")
            .font(.largeTitle)
            .bold()
            .padding(.top, 20)
        
        List {
            ForEach(viewModel.cartItems) { item in
                HStack {
                    if let product = item.product {
                        AsyncImage(url: URL(string: product.image)) { image in
                            image.resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                        } placeholder: {
                            ProgressView()
                                .frame(width: 100, height: 100)
                        }
                        
                        
                        
                        VStack(alignment: .leading) {
                            Text(product.title)
                                .font(.headline)
                            Text(String(format: "$%.2f", product.price))
                                .font(.subheadline)
                            
                            HStack {
                                Button(action: {
                                    viewModel.decreaseQuantity(for: item)
                                }) {
                                    Image(systemName: "minus.circle")
                                        .foregroundColor(.red)
                                }
                                .buttonStyle(PlainButtonStyle())
                                
                                Text("\(item.quantity)")
                                    .font(.title2)
                                    .frame(minWidth: 30)
                                
                                Button(action: {
                                    viewModel.increaseQuantity(for: item)
                                }) {
                                    Image(systemName: "plus.circle")
                                        .foregroundColor(.green)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                            .padding(.top, 5)
                        }
                    }
                }
            }
        }
        .onAppear {
            viewModel.loadCartItems()
        }
    }
}

#Preview {
    CartView()
}
