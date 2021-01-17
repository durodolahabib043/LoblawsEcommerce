//
//  ViewController.swift
//  LobLawsEcommerce
//
//  Created by Habib Durodola on 2021-01-14.
//

import UIKit

class HomeController: UICollectionViewController , HomeModelViewDelete{


    let cellId = "productCellId"
    var productList: [Entry] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        let homeMV = HomeModelView()
        homeMV.delegate = self
        homeMV.fetchData()
        setupNaviagtionTitle()
    }
    //MARK:- NAV
    func setupNaviagtionTitle(){
        setNavigtionBarItems()
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Products"
        navigationItem.titleView = label
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .white
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: cellId)
    }


    //MARK: - COLLECTION DELEGATE
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ProductCell
        cell.loblowsProduct = productList[indexPath.item]
        if (indexPath.row == 1) {
            let font = UIFont.boldSystemFont(ofSize: 22)
            let attributes = [NSAttributedString.Key.font: font , NSAttributedString.Key.foregroundColor : UIColor.red]

            let attributedProductName = NSAttributedString(string: "$2.99 ", attributes: attributes)
            let strikeOutText = NSMutableAttributedString()
            strikeOutText.append(attributedProductName)
            strikeOutText.append(productList[indexPath.row].price.strikeThrough())
            cell.productPrice.attributedText = strikeOutText
        }
        return cell
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.collectionView.collectionViewLayout.invalidateLayout()

        super.viewWillTransition(to: size, with: coordinator)
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productDetailVC = ProductDetailController()
        productDetailVC.entry = productList[indexPath.item]
        self.changeBackColor(title: productList[indexPath.item].type)
        self.navigationController?.pushViewController(productDetailVC, animated: true)
    }

    //MARK:- HOMEDELEGATE
    func networkApiFails(error: String) {
        DispatchQueue.main.async {
            self.showErrorMessage(title: "Error", message: error)
        }
    }

    func networkApiSuccessful(entry: [Entry]) {
        self.productList = entry
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

