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

        let apiClient = ApiClient.shared

        apiClient.fetchCart(inputJson: Constants.CART_JSON) { [weak self](entry, err) in
            guard let self = self else { return }
//=======
//        let apiClient = ApiClient()
//        apiClient.fetchCart(inputJson: Constants.CART_JSON) { (entry, err) in
//>>>>>>> 945456d ( code clean up)
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
