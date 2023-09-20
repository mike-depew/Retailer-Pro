//  NetworkManager.swift
//  RetailerPro | Created by Mike Depew

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    func fetchProducts(completion: @escaping ([Product]?, Error?) -> Void) {
        guard let url = URL(string: "https://fakestoreapi.com/products") else {
            completion(nil, NSError(domain: "Invalid URL", code: 0, userInfo: nil))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let data = data else {
                completion(nil, NSError(domain: "No Data", code: 0, userInfo: nil))
                return
            }
            do {
                let products = try JSONDecoder().decode([Product].self, from: data)
                completion(products, nil)
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
    }
}
