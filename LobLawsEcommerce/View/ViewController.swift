//
//  ViewController.swift
//  LobLawsEcommerce
//
//  Created by Habib Durodola on 2021-01-14.
//

import UIKit

class ViewController: UICollectionViewController {

    let cellId = "productCellId"
    var productList: [Entry] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        let apiClient = ApiClient()
        apiClient.fetchCart(inputJson: "") { (entry, test) in
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
        let productDetailVC = ProductDetailController()
        productDetailVC.entry = productList[indexPath.item]
        self.navigationController?.pushViewController(productDetailVC, animated: true)
    }

}

extension ViewController : UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width/2)-20, height: view.frame.height/3)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 10, bottom: 1, right: 10)
    }

}
