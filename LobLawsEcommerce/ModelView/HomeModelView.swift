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
<<<<<<< HEAD
        let apiClient = ApiClient.shared
        
=======
        let apiClient = ApiClient()
>>>>>>> cb74300 ( added search bar)
        apiClient.fetchCart(inputJson: Constants.CART_JSON) { [weak self](entry, err) in
            guard let self = self else { return }
            if (entry.count == 0){
                self.delegate.networkApiFails(error: err)
                return
            }
            self.delegate.networkApiSuccessful(entry: entry)
        }
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
