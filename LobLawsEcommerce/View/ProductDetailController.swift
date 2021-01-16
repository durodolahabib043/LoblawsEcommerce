//
//  ProductDetailController.swift
//  LobLawsEcommerce
//
//  Created by Habib Durodola on 2021-01-15.
//

import UIKit

class ProductDetailController: UIViewController {

    var entry: Entry?
    //MARK:- VIEWS
    var safeArea: UILayoutGuide!
    lazy var productImage : CustomImageView = {
        let image = CustomImageView()
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = false
        image.translatesAutoresizingMaskIntoConstraints = false
        //self.clipsToBounds = true
        return image
    }()

    let productName : UILabel = {
        let textview = UILabel()
        textview.translatesAutoresizingMaskIntoConstraints = false
        textview.numberOfLines = 3
        textview.textColor = .blue
        textview.font = UIFont.systemFont(ofSize: 20)
        return textview
    }()
    let productPrice : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .brown
        return label
    }()
    let productType : UILabel = {
        let textview = UILabel()
        textview.translatesAutoresizingMaskIntoConstraints = false
        textview.font = UIFont.systemFont(ofSize: 20)
        textview.textColor = .orange
        return textview
    }()
    let productCode : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .red
        return label
    }()

    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = .white
        return scroll
    }()

    //MARK:- LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()

    }

    //MARK:- HANDLERS
    func setupViews(){
        view.addSubview(scrollView)
        setupAutoLayout()
        populateProductDetails(productEntry: entry)
    }

    func setupAutoLayout(){
        var constraints = [NSLayoutConstraint]()
        let containerView: [UIView] = [productImage,productName,productType, productCode,productPrice]

        let fullStackView = UIStackView.init(arrangedSubviews: containerView)
        fullStackView.axis = .vertical
        fullStackView.alignment = .fill
        fullStackView.distribution = .fill
        //fullStackView.spacing = 3
        fullStackView.translatesAutoresizingMaskIntoConstraints = false

        scrollView.addSubview(fullStackView)
        safeArea = view.safeAreaLayoutGuide

        constraints += [NSLayoutConstraint.init(item: scrollView, attribute: .leading, relatedBy: .equal, toItem: safeArea, attribute: .leading, multiplier: 1.0, constant: 0.0)]

        constraints += [NSLayoutConstraint.init(item: scrollView, attribute: .trailing, relatedBy: .equal, toItem: safeArea, attribute: .trailing, multiplier: 1.0, constant: 0.0)]

        constraints += [NSLayoutConstraint.init(item: scrollView, attribute: .top, relatedBy: .equal, toItem: safeArea, attribute: .top, multiplier: 1.0, constant: 0.0)]
        constraints += [NSLayoutConstraint.init(item: scrollView, attribute: .bottom, relatedBy: .equal, toItem: safeArea, attribute: .bottom, multiplier: 1.0, constant: 0.0)]



        constraints += [NSLayoutConstraint.init(item: fullStackView, attribute: .leading, relatedBy: .equal, toItem: safeArea, attribute: .leading, multiplier: 1.0, constant: 0.0)]

        constraints += [NSLayoutConstraint.init(item: fullStackView, attribute: .trailing, relatedBy: .equal, toItem: safeArea, attribute: .trailing, multiplier: 1.0, constant: 0.0)]

        constraints += [NSLayoutConstraint.init(item: fullStackView, attribute: .top, relatedBy: .equal, toItem: scrollView, attribute: .top, multiplier: 1.0, constant: 0.0)]
        constraints += [NSLayoutConstraint.init(item: fullStackView, attribute: .bottom, relatedBy: .equal, toItem: scrollView, attribute: .bottom, multiplier: 1.0, constant: 0.0)]

        view.addConstraints(constraints)
        
    }

    func populateProductDetails(productEntry: Entry?){
        if let product = productEntry {
            productImage.loadImageUsingUrlString(urlString: product.image)
            productName.text = "Product Name: \(product.name)"
            productType.text = "Product Type: \(product.type)"
            productCode.text = "Product Code: \(product.code)"
            productPrice.text = "Product Price \(product.price)"

        }

    }


}
