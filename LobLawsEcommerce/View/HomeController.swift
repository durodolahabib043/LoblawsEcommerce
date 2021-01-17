//
//  ViewController.swift
//  LobLawsEcommerce
//
//  Created by Habib Durodola on 2021-01-14.
//

import UIKit

class HomeController: UICollectionViewController {

    let cellId = "productCellId"
    var productList: [Entry] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        let apiClient = ApiClient()
        apiClient.fetchCart(inputJson: "") { (entry, err) in
            if (entry.count == 0){
                DispatchQueue.main.async {
                    self.showErrorMessage(title: "Error", message: err)
                }
                return
            }
            self.productList = entry
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        setupNaviagtionTitle()
    }
    //MARK:- NAV
    func setupNaviagtionTitle(){
        navigationItem.title = "Products"
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
        let backItem = UIBarButtonItem()
        let productDetailVC = ProductDetailController()
        productDetailVC.entry = productList[indexPath.item]
        backItem.title = productList[indexPath.item].type
        backItem.tintColor = .blue
        navigationItem.backBarButtonItem = backItem
        self.navigationController?.pushViewController(productDetailVC, animated: true)
    }

}

