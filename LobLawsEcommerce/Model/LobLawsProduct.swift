//
//  LobLawsProduct.swift
//  LobLawsEcommerce
//
//  Created by Habib Durodola on 2021-01-14.
//

import Foundation

struct LoblawsProduct: Codable {
    let entries: [Entry]
}

// MARK: - Entry
struct Entry: Codable {
    let code: String
    let image: String
    let name, price, type: String
}

