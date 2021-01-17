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
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()

    let productAbout : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 50
        label.textColor = .black
        return label
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

        let cartVC = CartViewController()
        cartVC.entry = entry
        if let title = entry {
            self.changeBackColor(title: title.type)
        }
        navigationController?.pushViewController(cartVC, animated: true)
    }

}

