//
//  HomeModelView.swift
//  LobLawsEcommerce
//
//  Created by Habib Durodola on 2021-01-17.
//

import UIKit

protocol HomeModelViewDelete {
    func networkApiFails(error : String)
    func networkApiSuccessful(entry : [Entry])
}

class HomeModelView {
    var delegate : HomeModelViewDelete!

    func fetchData(){
        let apiClient = ApiClient()

        apiClient.getCartPromise().done({
            result in
            if (result.entries.count == 0){
                self.delegate.networkApiFails(error: "err")
                return
            }
            self.delegate.networkApiSuccessful(entry: result.entries)

        }).catch({
            err in
            print(err)
            self.delegate.networkApiFails(error: "err")
        })

        //        apiClient.fetchCart(inputJson: Constants.CART_JSON) { (entry, err) in
        //            if (entry.count == 0){
        //                self.delegate.networkApiFails(error: err)
        //                return
        //            }
        //
        ////            apiClient.fetchPromo(inputJson: "") { (promo, err) in
        ////
        ////                for (index , value) in entry.enumerated() {
        ////
        ////                    if let promoCC = promo.first(where: {$0.type == value.type}){
        ////                        print(promoCC.type)
        ////                    }
        ////                }
        ////
        ////            }
        //            self.delegate.networkApiSuccessful(entry: entry)
        //        }
    }

    func displayPrice(price : String)->NSMutableAttributedString{
        let font = UIFont.boldSystemFont(ofSize: 22)
        let attributes = [NSAttributedString.Key.font: font , NSAttributedString.Key.foregroundColor : UIColor.red]

        let attributedProductName = NSAttributedString(string: "$2.99 ", attributes: attributes)
        let strikeOutText = NSMutableAttributedString()
        strikeOutText.append(attributedProductName)
        strikeOutText.append(price.strikeThrough())

        return strikeOutText
    }
}
