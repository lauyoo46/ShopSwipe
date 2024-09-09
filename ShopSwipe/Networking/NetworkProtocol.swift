//
//  NetworkProtocol.swift
//  ShopSwipe
//
//  Created by Laurentiu Ile on 08.09.2024.
//

import Foundation

protocol NetworkService {
    func fetchProducts(limit: Int, completion: @escaping (Result<[Product], Error>) -> Void)
}
