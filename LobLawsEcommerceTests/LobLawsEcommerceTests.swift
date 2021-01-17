//
//  LobLawsEcommerceTests.swift
//  LobLawsEcommerceTests
//
//  Created by Habib Durodola on 2021-01-17.
//

import XCTest
@testable import LobLawsEcommerce

class LobLawsEcommerceTests: XCTestCase {


    func testDisplayName() {
        let homeMVVM = HomeModelView()

        let strikeOutText = NSMutableAttributedString()
        let font = UIFont.boldSystemFont(ofSize: 22)
        let attributes = [NSAttributedString.Key.font: font , NSAttributedString.Key.foregroundColor : UIColor.red]
        let attributedProductName = NSAttributedString(string: "$2.99 ", attributes: attributes
        )
        strikeOutText.append(attributedProductName)
        strikeOutText.append("@2.44".strikeThrough())

        XCTAssertNotEqual(homeMVVM.displayPrice(price: "$2.4"), strikeOutText)


    }

}
