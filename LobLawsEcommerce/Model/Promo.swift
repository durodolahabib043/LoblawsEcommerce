//
//  Promo.swift
//  LobLawsEcommerce
//
//  Created by Habib Durodola on 2021-01-29.
//

import Foundation


struct PromoProduct : Codable {
    let promos : [Promo]

}


// MARK: - Promo
struct Promo: Codable {
    let promoID, type, promotText: String

    enum CodingKeys: String, CodingKey {
        case promoID = "promoId"
        case type, promotText
    }
}
