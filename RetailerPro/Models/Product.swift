//  Product.swift
//  RetailerPro | by Mike Depew
//

import Foundation

struct Product: Codable {
    let id: Int
    let title: String
    let category: String
    let description: String
    let price: Double
    let image: String
}
