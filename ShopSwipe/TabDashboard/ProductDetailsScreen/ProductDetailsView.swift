//
//  ProductDetailsView.swift
//  ShopSwipe
//
//  Created by Laurentiu Ile on 05.09.2024.
//

import SwiftUI

struct ProductDetailsView: View {
    @EnvironmentObject var viewModel: ProductDetailsViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text(viewModel.product.title)
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .padding(.top, 10)
                    .padding(.horizontal, 16)
                
                Spacer()
                
                AsyncImage(url: URL(string: viewModel.product.image)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 200)
                    case .failure:
                        Image(systemName: "photo")
                    @unknown default:
                        EmptyView()
                    }
                }
                
                Text(String(format: "$%.2f", viewModel.product.price))
                    .font(.title2)
                    .foregroundColor(.green)
                
                Text(viewModel.product.productDescription)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .padding(.horizontal, 16)
                
                Spacer()
                
                if viewModel.productJustAddedToCart {
                    Text("Product added to cart!")
                        .font(.subheadline)
                        .foregroundColor(.green)
                        .padding(.bottom, 10)
                }
                
                
                
                Button(action: {
                    viewModel.addToCart()
                }) {
                    Text("Add to Cart")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 16)
                
                Spacer()
                
                if !viewModel.recommendedProducts.isEmpty {
                    VStack(alignment: .leading) {
                        Text("Recommended items")
                            .font(.title2)
                            .bold()
                            .padding(.horizontal, 16)
                            .padding(.top, 20)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(viewModel.recommendedProducts) { product in
                                    VStack {
                                        AsyncImage(url: URL(string: product.image)) { phase in
                                            switch phase {
                                            case .empty:
                                                ProgressView()
                                            case .success(let image):
                                                image
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 100, height: 100)
                                            case .failure:
                                                Image(systemName: "photo")
                                                    .frame(width: 100, height: 100)
                                            @unknown default:
                                                EmptyView()
                                            }
                                        }

                                        Text(product.title)
                                            .font(.footnote)
                                            .lineLimit(2)
                                            .frame(width: 100)
                                            .multilineTextAlignment(.center)
                                    }
                                    .onTapGesture {
                                        viewModel.selectProduct(product)
                                    }
                                }
                            }
                            .padding(.horizontal, 16)
                        }
                    }
                }
                
                Spacer()
            }
        }
    }

}

#Preview {
    ProductDetailsView()
}
