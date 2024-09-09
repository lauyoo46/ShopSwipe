//
//  NetworkManager.swift
//  ShopSwipe
//
//  Created by Laurentiu Ile on 08.09.2024.
//

import Foundation

class NetworkManager: NetworkService {
    
    static let shared = NetworkManager()
    private init() {}

    func fetchProducts(limit: Int, completion: @escaping (Result<[Product], Error>) -> Void) {
        let fetchProductsString = "https://fakestoreapi.com/products?limit=\(limit)"
        guard let url = URL(string: fetchProductsString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data, let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }

            do {
                let products = try JSONDecoder().decode([Product].self, from: data)
                completion(.success(products))
            } catch {
                completion(.failure(NetworkError.decodingError))
            }
        }
        task.resume()
    }
}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
}
