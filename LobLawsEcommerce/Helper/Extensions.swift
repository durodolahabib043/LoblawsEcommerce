//
//  Extensions.swift
//  LobLawsEcommerce
//
//  Created by Habib Durodola on 2021-01-16.
//

import UIKit


extension NSMutableAttributedString {
    func setProductNameType(product: String , productType: String)->NSMutableAttributedString {
        let quote = "\(product)"
        let font = UIFont.boldSystemFont(ofSize: 16)
        let attributes = [NSAttributedString.Key.font: font]

        let attributedProductName = NSAttributedString(string: quote, attributes: attributes)
        let attributedProductType = NSAttributedString(string: "\n\(productType)", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray
            , NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20)])
        let combination = NSMutableAttributedString()
        combination.append(attributedProductName)
        combination.append(attributedProductType)
        return combination
    }
}

extension String {
    func strikeThrough() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(
            NSAttributedString.Key.strikethroughStyle,
               value: NSUnderlineStyle.single.rawValue,
                   range:NSMakeRange(0,attributeString.length))
        return attributeString
    }
}

extension UIViewController {
    func showErrorMessage(title : String , message: String){
        // Create new Alert
        let dialogMessage = UIAlertController(title: title, message: message, preferredStyle: .alert)
        self.present(dialogMessage, animated: true, completion: nil)
    }
}
