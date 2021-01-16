//
//  ApiClient.swift
//  LobLawsEcommerce
//
//  Created by Habib Durodola on 2021-01-14.
//

import Foundation

class ApiClient {
    var errorMessage = ""

    func fetchCart(inputJson:String , completionHandler: @escaping ([Entry] , _ error: String) -> Void) {
        let url = URL(string: Constants.BASE_URL + Constants.CART_JSON)!
        var cartEntry: [Entry] = []
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                self.errorMessage += "DataTask error: " + error.localizedDescription + "\n"

            } else if
                let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200{
                do {
                    let cart = try JSONDecoder().decode(LoblawsProduct.self, from: data)
                    cartEntry = cart.entries

                 } catch {
                       self.errorMessage = "error"
                 }
            }
            else if
                let response = response as? HTTPURLResponse,
                (400...500).contains(response.statusCode) {
                cartEntry = [];

            }
            completionHandler(cartEntry , self.errorMessage)
        })
        task.resume()
    }
}
