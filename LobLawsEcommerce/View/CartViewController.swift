//
//  CartViewController.swift
//  LobLawsEcommerce
//
//  Created by Habib Durodola on 2021-01-16.
//

import UIKit

class CartViewController: UIViewController {

    var safeArea: UILayoutGuide!
    var entry: Entry?

    lazy var productImage : CustomImageView = {
        let image = CustomImageView()
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = false
        image.translatesAutoresizingMaskIntoConstraints = false
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
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()

        // Do any additional setup after loading the view.
    }

    func setupView() {
        view.addSubview(productImage)
        view.addSubview(productName)
        view.addSubview(productPrice)
        addAutolayout()
        displayCart()

    }

    func addAutolayout(){
        var constraints = [NSLayoutConstraint]()
        let containerView: [UIView] = [productImage,productName,productPrice]

        let fullStackView = UIStackView.init(arrangedSubviews: containerView)
        fullStackView.axis = .horizontal
        fullStackView.alignment = .fill
        fullStackView.distribution = .fill
        fullStackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(fullStackView)
        safeArea = view.safeAreaLayoutGuide

        // MARK:- fullStackView
        constraints += [NSLayoutConstraint.init(item: fullStackView, attribute: .top, relatedBy: .equal, toItem: safeArea, attribute: .top, multiplier: 1.0, constant: 0.0)]
        constraints += [NSLayoutConstraint.init(item: fullStackView, attribute: .leading, relatedBy: .equal, toItem: safeArea, attribute: .leading, multiplier: 1.0, constant: 0.0)]
        // trailing fullStackView
        constraints += [NSLayoutConstraint.init(item: fullStackView, attribute: .trailing, relatedBy: .equal, toItem: safeArea, attribute: .trailing, multiplier: 1.0, constant: -5.0)]

        // MARK:- productImage
        constraints += [NSLayoutConstraint.init(item: productImage, attribute: .height, relatedBy: .equal, toItem: safeArea, attribute: .height, multiplier: 1/3, constant: 0.0)]

        constraints += [NSLayoutConstraint.init(item: productPrice, attribute: .width, relatedBy: .equal, toItem: safeArea, attribute: .width, multiplier: 1/4, constant: 0.0)]

        view.addConstraints(constraints)

    }

    func displayCart(){

        if let cart = entry {
            productImage.loadImageUsingUrlString(urlString: cart.image)
            productName.attributedText = NSMutableAttributedString().setProductNameType(product: cart.type, productType: cart.name)
            productPrice.text = "\(cart.price)"
        }

    }
}
