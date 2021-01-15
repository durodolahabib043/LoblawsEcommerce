//
//  ProductCell.swift
//  LobLawsEcommerce
//
//  Created by Habib Durodola on 2021-01-14.
//

import UIKit

class ProductCell: UITableViewCell {

    var safeArea: UILayoutGuide!

    lazy var productImage : CustomImageView = {
        let image = CustomImageView()
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = false
        image.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
        return image
    }()

    let productName : UILabel = {
        let textview = UILabel()
        textview.translatesAutoresizingMaskIntoConstraints = false
        textview.numberOfLines = 7
        return textview
    }()
    let productPrice : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .purple
        return label
    }()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView() {
        addSubview(productImage)
        addSubview(productName)
        addSubview(productPrice)
        addAutolayout()

    }

    func addAutolayout(){
        var constraints = [NSLayoutConstraint]()
        let containerView: [UIView] = [productImage,productName,productPrice]

        let fullStackView = UIStackView.init(arrangedSubviews: containerView)
        fullStackView.axis = .horizontal
        fullStackView.alignment = .fill
        fullStackView.distribution = .fill
        fullStackView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(fullStackView)
        safeArea = safeAreaLayoutGuide

        // MARK:- fullStackView
        constraints += [NSLayoutConstraint.init(item: fullStackView, attribute: .leading, relatedBy: .equal, toItem: safeArea, attribute: .leading, multiplier: 1.0, constant: 0.0)]
        // trailing fullStackView
        constraints += [NSLayoutConstraint.init(item: fullStackView, attribute: .trailing, relatedBy: .equal, toItem: safeArea, attribute: .trailing, multiplier: 1.0, constant: -5.0)]

        constraints += [NSLayoutConstraint.init(item: fullStackView, attribute: .centerY, relatedBy: .equal, toItem: safeArea, attribute: .centerY, multiplier: 1.0, constant: 0.0)]


        constraints += [NSLayoutConstraint.init(item: productImage, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 64.0)]
        constraints += [NSLayoutConstraint.init(item: productImage, attribute: .width, relatedBy: .equal, toItem: productImage, attribute: .height, multiplier: 1.0, constant: 30.0)]
        constraints += [NSLayoutConstraint.init(item: productPrice, attribute: .width, relatedBy: .equal, toItem: safeArea, attribute: .width, multiplier: 1/4, constant: 0.0)]

        addConstraints(constraints)

    }


    var loblowsProduct : Entry? {
        didSet {
            guard let products = loblowsProduct else {
                return
            }

            productImage.loadImageUsingUrlString(urlString: products.image)
            setProductNameType(product: products.name, productType: products.type)
            productPrice.text = "\(products.price)  >"
        }
    }

    func setProductNameType(product: String , productType: String){
        let quote = "Product Name: \(product)"
        let font = UIFont.systemFont(ofSize: 12)
        let attributes = [NSAttributedString.Key.font: font , NSAttributedString.Key.foregroundColor : UIColor.blue]

        let attributedProductName = NSAttributedString(string: quote, attributes: attributes)
        let attributedProductType = NSAttributedString(string: "\nProduct Type: \(productType)", attributes: [NSAttributedString.Key.foregroundColor : UIColor.red
            , NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12)])
        let combination = NSMutableAttributedString()
        combination.append(attributedProductName)
        combination.append(attributedProductType)

        productName.attributedText = combination
    }


}
