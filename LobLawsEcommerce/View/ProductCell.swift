//
//  ProductCell.swift
//  LobLawsEcommerce
//
//  Created by Habib Durodola on 2021-01-14.
//

import UIKit

class ProductCell: UICollectionViewCell {

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
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
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
        addBorder()
        var constraints = [NSLayoutConstraint]()
        let containerView: [UIView] = [productImage,productName,productPrice]

        let fullStackView = UIStackView.init(arrangedSubviews: containerView)
        fullStackView.axis = .vertical
        fullStackView.alignment = .fill
        fullStackView.distribution = .fill

        fullStackView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(fullStackView)
        safeArea = safeAreaLayoutGuide

        // MARK:- fullStackView
        constraints += [NSLayoutConstraint.init(item: fullStackView, attribute: .leading, relatedBy: .equal, toItem: safeArea, attribute: .leading, multiplier: 1.0, constant: 10.0)]
        // trailing fullStackView
        constraints += [NSLayoutConstraint.init(item: fullStackView, attribute: .trailing, relatedBy: .equal, toItem: safeArea, attribute: .trailing, multiplier: 1.0, constant: 0.0)]

        constraints += [NSLayoutConstraint.init(item: fullStackView, attribute: .top, relatedBy: .equal, toItem: safeArea, attribute: .top, multiplier: 1.0, constant: 10.0)]

        constraints += [NSLayoutConstraint.init(item: productImage, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 150.0)]

        addConstraints(constraints)

    }

    func addBorder(){
        layer.masksToBounds = true
        layer.cornerRadius = 5
        layer.borderWidth = 1
        let borderColor: UIColor =  .lightGray
        layer.borderColor = borderColor.cgColor
    }

    var loblowsProduct : Entry? {
        didSet {
            guard let products = loblowsProduct else {
                return
            }

            productImage.loadImageUsingUrlString(urlString: products.image)
            setProductNameType(product: products.name, productType: products.type)
            productPrice.text = "\(products.price)"
        }
    }

    func setProductNameType(product: String , productType: String){
        let quote = "\(product)"
        let font = UIFont.boldSystemFont(ofSize: 16)
        let attributes = [NSAttributedString.Key.font: font]

        let attributedProductName = NSAttributedString(string: quote, attributes: attributes)
        let attributedProductType = NSAttributedString(string: "\n\(productType)", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray
            , NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20)])
        let combination = NSMutableAttributedString()
        combination.append(attributedProductName)
        combination.append(attributedProductType)

        productName.attributedText = combination
    }


}
