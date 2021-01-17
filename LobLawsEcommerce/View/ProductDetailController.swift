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
    var counter = 0
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
        textview.numberOfLines = 3
        textview.font = UIFont.systemFont(ofSize: 20)
        return textview
    }()
    let productPrice : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    let productType : UILabel = {
        let textview = UILabel()
        textview.translatesAutoresizingMaskIntoConstraints = false
        textview.font = UIFont.systemFont(ofSize: 20)
        textview.textColor = .orange
        return textview
    }()


    let cartBtn : UIButton = {
        let button = UIButton()
        button.setTitle("ADD TO CART", for: .normal)
        button.backgroundColor = . black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 2
        button.addTarget(self, action:#selector(handleCart), for: .touchUpInside)
        return button

    }()

    let productCode : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()

    let productAbout : UILabel = {
        let textview = UILabel()
        textview.translatesAutoresizingMaskIntoConstraints = false
        textview.font = UIFont.systemFont(ofSize: 20)
        textview.numberOfLines = 50
        return textview
    }()

    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.contentInset = UIEdgeInsets(top: 30, left: 20, bottom: 0, right: 20)
        scroll.contentOffset.x = 0
        return scroll
    }()

    let checkOutBtn : UIButton = {
        let button = UIButton()
        button.backgroundColor = .orange
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        button.addTarget(self, action:#selector(launchCartController), for: .touchUpInside)
        return button

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

    func populateProductDetails(productEntry: Entry?){
        if let product = productEntry {
            productImage.loadImageUsingUrlString(urlString: product.image)
            productPrice.text = "\(product.price)"
            productName.attributedText = NSMutableAttributedString().setProductNameType(product: product.type, productType: product.name)
            productCode.text = "About this product  SKU #\(product.code)"
        }

    }

    @objc func handleCart(){
        counter += 1
        UIView.transition(with: checkOutBtn, duration: 0.4,
                          options: .transitionCrossDissolve,
                          animations: {
                            self.checkOutBtn.setTitle("\(self.counter) item(s) in your bag", for: .normal)
                            self.checkOutBtn.isHidden = false

                          })
    }

    @objc func launchCartController(){
        navigationController?.pushViewController(CartViewController(), animated: true)
    }

}

