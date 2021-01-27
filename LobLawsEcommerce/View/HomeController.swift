//
//  ViewController.swift
//  LobLawsEcommerce
//
//  Created by Habib Durodola on 2021-01-14.
//

import UIKit

class HomeController: UICollectionViewController , HomeModelViewDelete , UISearchBarDelegate{

    let cellId = "productCellId"
    let productHeader = "headerView"
    var productList: [Entry] = []
    var reloadCollectionView = [Entry]()
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
        collectionView.register(ProductHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: productHeader)

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

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView  = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: productHeader, for: indexPath) as! ProductHeaderView
        headerView.searchBar.delegate = self
        if let searchTextField = headerView.searchBar.value(forKey: "searchField") as? UITextField , let clearButton = searchTextField.value(forKey: "_clearButton")as? UIButton {

            clearButton.addTarget(self, action: #selector(self.clearCollectionView), for: .touchUpInside)
        }
        return headerView
    }


    //MARK:- HOMEDELEGATE
    func networkApiFails(error: String) {
        DispatchQueue.main.async {
            self.showErrorMessage(title: "Error", message: error)
        }
    }

    func networkApiSuccessful(entry: [Entry]) {
        self.productList = entry
        reloadCollectionView = entry
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){

        var filtered = [Entry]()
        filtered = productList
        productList = searchBar.text!.isEmpty ? filtered : filtered.filter({ (entry) -> Bool in
            return entry.name.range(of: searchBar.text!, options: .caseInsensitive) != nil
        })
        collectionView.reloadData()
        searchBar.resignFirstResponder()
        searchBar.endEditing(true)
    }

    @objc func clearCollectionView() {
        productList = reloadCollectionView
        collectionView.reloadData()
        print("clearCollectionView")
    }
}

