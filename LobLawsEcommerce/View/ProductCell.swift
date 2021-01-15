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
        self.clipsToBounds = true

        return image
    }()

    let productName : UITextView = {
        let textview = UITextView()
        return textview
    }()
    let productPrice : UILabel = {
        let label = UILabel()
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
        backgroundColor = .lightGray
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
        fullStackView.spacing = 3
        fullStackView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(fullStackView)
        safeArea = safeAreaLayoutGuide
        //MARK:- fullStackView
        // leading fullStackView
        constraints += [NSLayoutConstraint.init(item: fullStackView, attribute: .leading, relatedBy: .equal, toItem: safeArea, attribute: .leading, multiplier: 1.0, constant: 0.0)]
        // trailing fullStackView
        constraints += [NSLayoutConstraint.init(item: fullStackView, attribute: .trailing, relatedBy: .equal, toItem: safeArea, attribute: .trailing, multiplier: 1.0, constant: 0.0)]
//        constraints += [NSLayoutConstraint.init(item: fullStackView, attribute: .top, relatedBy: .equal, toItem: safeArea, attribute: .top, multiplier: 1.0, constant: 0.0)]
        constraints += [NSLayoutConstraint.init(item: fullStackView, attribute: .centerY, relatedBy: .equal, toItem: safeArea, attribute: .centerY, multiplier: 1.0, constant: 0.0)]

        constraints += [NSLayoutConstraint.init(item: productImage, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 64.0)]
        constraints += [NSLayoutConstraint.init(item: productImage, attribute: .width, relatedBy: .equal, toItem: productImage, attribute: .height, multiplier: 1.0, constant: 64.0)]

        addConstraints(constraints)

    }


    var loblowsProduct : Entry? {
        didSet {
            guard let products = loblowsProduct else {
                return
            }
            productName.text = "\(products.name) \n\(products.type) \n\(products.code)"
            productPrice.text = products.price
            productImage.loadImageUsingUrlString(urlString: products.image)

        }
    }

}
