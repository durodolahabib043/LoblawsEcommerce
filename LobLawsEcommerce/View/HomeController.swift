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
    var homeMV: HomeModelView?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        homeMV = HomeModelView()
        if let homeMVVM = homeMV {
            homeMVVM.delegate = self
            homeMVVM.fetchData()
        }
        setupNaviagtionTitle()
    }
    //MARK:- NAV
    func setupNaviagtionTitle(){
        setNavigtionBarItems()
        setNavTitle()
        collectionView.backgroundColor = .white
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: cellId)
    }

    fileprivate func setNavTitle(){
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Products"
        navigationItem.titleView = label

    }


    //MARK: - COLLECTION DELEGATE
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ProductCell
        cell.loblowsProduct = productList[indexPath.item]
        if (indexPath.row == 1) {
            guard let homeMVVM = homeMV else {
                return cell
            }
            cell.productPrice.attributedText =  homeMVVM.displayPrice(price: productList[indexPath.row].price)
        }
        return cell
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

