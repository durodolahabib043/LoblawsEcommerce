//
//  LobLawsEcommerceTests.swift
//  LobLawsEcommerceTests
//
//  Created by Habib Durodola on 2021-01-17.
//

import XCTest
@testable import LobLawsEcommerce

class LobLawsEcommerceTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

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

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
