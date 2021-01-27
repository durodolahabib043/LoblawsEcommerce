//
//  Extensions.swift
//  LobLawsEcommerce
//
//  Created by Habib Durodola on 2021-01-16.
//

import UIKit


//MARK:- NSMutableAttributedString
extension NSMutableAttributedString {
    func setProductNameType(product: String , productType: String)->NSMutableAttributedString {
        let quote = "\(product)"
        let font = UIFont.boldSystemFont(ofSize: 16)
        let attributes = [NSAttributedString.Key.font: font , NSAttributedString.Key.foregroundColor : UIColor.black]

        let attributedProductName = NSAttributedString(string: quote, attributes: attributes)
        let attributedProductType = NSAttributedString(string: "\n\(productType)", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray
            , NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20)])
        let combination = NSMutableAttributedString()
        combination.append(attributedProductName)
        combination.append(attributedProductType)
        return combination
    }
}
//MARK:- String
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

//MARK:- UIViewController
extension UIViewController {
    func showErrorMessage(title : String , message: String){
        // Create new Alert
        let dialogMessage = UIAlertController(title: title, message: message, preferredStyle: .alert)
        self.present(dialogMessage, animated: true, completion: nil)
    }
    func changeBackColor(title : String){
        let backItem = UIBarButtonItem()
         backItem.title = title
        backItem.tintColor = .white
        navigationItem.backBarButtonItem = backItem
    }
     func setNavigtionBarItems() {
          if #available(iOS 13.0, *) {
              let appearance = UINavigationBarAppearance()
              appearance.configureWithDefaultBackground()
              appearance.backgroundColor = .red
              navigationController?.navigationBar.standardAppearance = appearance
              navigationController?.navigationBar.scrollEdgeAppearance = appearance
          } else {
              // Fallback on earlier versions
              navigationController?.navigationBar.barTintColor = .red
          }
      }
}

//MARK:- HomeController
extension HomeController : UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width/2)-20, height: view.frame.height/3)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 10, bottom: 1, right: 10)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
           return CGSize(width: collectionView.frame.width, height: 50)
       }
}

//MARK:- ProductDetailController
extension ProductDetailController {
    func setupAutoLayout(){

        var constraints = [NSLayoutConstraint]()

        let containerView: [UIView] = [productImage, productPrice, cartBtn , productCode]
        let fullStackView = UIStackView.init(arrangedSubviews: containerView)
        fullStackView.axis = .vertical
        fullStackView.alignment = .fill
        fullStackView.distribution = .fill
        fullStackView.spacing = 5
        fullStackView.translatesAutoresizingMaskIntoConstraints = false

        scrollView.addSubview(productName)
        scrollView.addSubview(fullStackView)
        scrollView.addSubview(productAbout)
        view.addSubview(checkOutBtn)
        safeArea = view.safeAreaLayoutGuide
        ///productName
        constraints += [NSLayoutConstraint.init(item: productName, attribute: .leading, relatedBy: .equal, toItem: scrollView, attribute: .leading, multiplier: 1.0, constant: 0.0)]

        constraints += [NSLayoutConstraint.init(item: productName, attribute: .trailing, relatedBy: .equal, toItem: safeArea, attribute: .trailing, multiplier: 1.0, constant: 0.0)]
        constraints += [NSLayoutConstraint.init(item: productName, attribute: .top, relatedBy: .equal, toItem: scrollView, attribute: .top, multiplier: 1.0, constant: 10.0)]

        ///scrollView
        constraints += [NSLayoutConstraint.init(item: scrollView, attribute: .leading, relatedBy: .equal, toItem: safeArea, attribute: .leading, multiplier: 1.0, constant: 0.0)]

        constraints += [NSLayoutConstraint.init(item: scrollView, attribute: .trailing, relatedBy: .equal, toItem: safeArea, attribute: .trailing, multiplier: 1.0, constant: 0.0)]

        constraints += [NSLayoutConstraint.init(item: scrollView, attribute: .top, relatedBy: .equal, toItem: safeArea, attribute: .top, multiplier: 1.0, constant: 0.0)]
        constraints += [NSLayoutConstraint.init(item: scrollView, attribute: .bottom, relatedBy: .equal, toItem: safeArea, attribute: .bottom, multiplier: 1.0, constant: 0.0)]


        ///productImage
        constraints += [NSLayoutConstraint.init(item: productImage, attribute: .height, relatedBy: .equal, toItem: safeArea, attribute: .height, multiplier: 1/3, constant: 0.0)]
        ///fullStackView
        constraints += [NSLayoutConstraint.init(item: fullStackView, attribute: .top, relatedBy: .equal, toItem: productName, attribute: .bottom, multiplier: 1.0, constant: 10.0)]

        ///cart btn
        constraints += [NSLayoutConstraint.init(item: cartBtn, attribute: .height, relatedBy: .equal, toItem: safeArea, attribute: .height, multiplier: 1/12, constant: 0.0)]
        constraints += [NSLayoutConstraint.init(item: cartBtn, attribute: .leading, relatedBy: .equal, toItem: safeArea, attribute: .leading, multiplier: 1.0, constant: 20.0)]
        constraints += [NSLayoutConstraint.init(item: cartBtn, attribute: .trailing, relatedBy: .equal, toItem: safeArea, attribute: .trailing, multiplier: 1.0, constant: -20.0)]


        ///productAbout btn
        constraints += [NSLayoutConstraint.init(item: productAbout, attribute: .leading, relatedBy: .equal, toItem: scrollView, attribute: .leading, multiplier: 1.0, constant: 0.0)]
        constraints += [NSLayoutConstraint.init(item: productAbout, attribute: .trailing, relatedBy: .equal, toItem: safeArea, attribute: .trailing, multiplier: 1.0, constant: 0.0)]
        constraints += [NSLayoutConstraint.init(item: productAbout, attribute: .top, relatedBy: .equal, toItem: productCode, attribute: .bottom, multiplier: 1.0, constant: 20.0)]
        constraints += [NSLayoutConstraint.init(item: productAbout, attribute: .bottom, relatedBy: .equal, toItem: scrollView, attribute: .bottom, multiplier: 1.0, constant: 0.0)]

        productAbout.text = "For time-strapped Canadians, a trip to the grocery store is often another thing to add to an already long to-do list. However, that to-do list is a whole lot more manageable thanks to Loblaw’s PC Express service, whereby you can pre-order groceries online for easy pick up when and where it’s convenient to you—a reserved PC Express parking spot at your preferred store, a PC Express self serve kiosk at your local Shoppers Drug Mart, or (commuters rejoice!) designated Ontario GO Stations. It’s the perfect solution, designed to free up time for what’s important.The team at Loblaw Digital launched the service in 2014 as Click&Collect and over the past several years have focused on scalability and acquisition. We’ve recently launched mission teams who, as a lean and agile team collectively focus on one single outcome and are given all the tools to make it happen – 5 Minute Pickup, 1st Time Customer Experience are just two of the many highly focused teams continuing to perfect our online grocery business. Interested in getting involved? We’re hiring!"

        ////checkOutBtn
        constraints += [NSLayoutConstraint.init(item: checkOutBtn, attribute: .leading, relatedBy: .equal, toItem: safeArea, attribute: .leading, multiplier: 1.0, constant: 0.0)]
        constraints += [NSLayoutConstraint.init(item: checkOutBtn, attribute: .trailing, relatedBy: .equal, toItem: safeArea, attribute: .trailing, multiplier: 1.0, constant: 0.0)]

        constraints += [NSLayoutConstraint.init(item: checkOutBtn, attribute: .bottom, relatedBy: .equal, toItem: safeArea, attribute: .bottom, multiplier: 1.0, constant: 0.0)]
        constraints += [NSLayoutConstraint.init(item: checkOutBtn, attribute: .height, relatedBy: .equal, toItem: safeArea, attribute: .height, multiplier: 1/12, constant: 0.0)]

        view.addConstraints(constraints)

    }
}

