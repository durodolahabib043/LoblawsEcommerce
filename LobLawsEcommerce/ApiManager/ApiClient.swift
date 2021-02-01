//
//  ApiClient.swift
//  LobLawsEcommerce
//
//  Created by Habib Durodola on 2021-01-14.
//

import Foundation
import PromiseKit



class ApiClient {


    //https://gist.githubusercontent.com/r2vq/4b22b5e8528a920a45f64906b3572ce2/raw/4494faeeb8596622d785a9960507bf1688f17413/promos.json

    let promoUrl = "https://gist.githubusercontent.com/r2vq/4b22b5e8528a920a45f64906b3572ce2/raw/4494faeeb8596622d785a9960507bf1688f17413/promos.json"



    //    func fetchPromoNNNN<T, U:Equatable, A: Codable>(inputJson:T ,responseNNNN: A, completionHandler: @escaping ([U] , _ error: T) -> Void) {
    //        let url = URL(string: promoUrl)!
    //        var cartEntry: [U] = []
    //        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
    //            if let error = error as NSError? {
    //                if error.code == -1009 {
    //                    self.errorMessage += "DataTask error: \n" + error.localizedDescription + "\n"
    //                }
    //
    //            } else if
    //                let data = data,
    //                let response = response as? HTTPURLResponse,
    //                response.statusCode == 200{
    //                do {
    //                    let cart = try JSONDecoder().decode(A.self, from: data)
    //                   // cartEntry = cart.promos
    //
    //                } catch {
    //                    self.errorMessage = "error"
    //                }
    //            }
    //            else if
    //                let response = response as? HTTPURLResponse,
    //                (400...500).contains(response.statusCode) {
    //                cartEntry = [];
    //
    //            }
    //
    //        })
    //        task.resume()
    //    }

    //    func fetchPromo(inputJson:String , completionHandler: @escaping ([Promo] , _ error: String) -> Void) {
    //        let url = URL(string: promoUrl)!
    //        var cartEntry: [Promo] = []
    //        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
    //            if let error = error as NSError? {
    //                if error.code == -1009 {
    //                    self.errorMessage += "DataTask error: \n" + error.localizedDescription + "\n"
    //                }
    //
    //            } else if
    //                let data = data,
    //                let response = response as? HTTPURLResponse,
    //                response.statusCode == 200{
    //                do {
    //                    let cart = try JSONDecoder().decode(PromoProduct.self, from: data)
    //                    cartEntry = cart.promos
    //
    //                } catch {
    //                    self.errorMessage = "error"
    //                }
    //            }
    //            else if
    //                let response = response as? HTTPURLResponse,
    //                (400...500).contains(response.statusCode) {
    //                cartEntry = [];
    //
    //            }
    //            completionHandler(cartEntry , self.errorMessage)
    //        })
    //        task.resume()
    //    }
    //



    func getCartPromise() -> Promise<LoblawsProduct> {
        let urlString = "\(Constants.BASE_URL)\(Constants.CART_JSON)"

        if let url = URL(string: urlString) {
            return firstly {
                URLSession.shared.dataTask(.promise, with: url)
            }.compactMap {
                return try JSONDecoder().decode(LoblawsProduct.self, from: $0.data)
            }

        }
        return Promise {
            err in
            let genericError = NSError(
                domain: "PromiseKitTutorial",
                code: 0,
                userInfo: [NSLocalizedDescriptionKey: err])
            err.reject(genericError)
        }
    }

    var errorMessage = ""

    func fetchCart(inputJson:String , completionHandler: @escaping ([Entry] , _ error: String) -> Void) {
        let url = URL(string: Constants.BASE_URL + inputJson)!
        var cartEntry: [Entry] = []
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error as NSError? {
                if error.code == -1009 {
                    self.errorMessage += "DataTask error: \n" + error.localizedDescription + "\n"
                }

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
