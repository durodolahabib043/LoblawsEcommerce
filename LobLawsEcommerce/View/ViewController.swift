//
//  ViewController.swift
//  LobLawsEcommerce
//
//  Created by Habib Durodola on 2021-01-14.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource  {

    let cellId = "productCellId"
    let tableView = UITableView()
    var productList: [Entry] = []
    override func loadView() {
        super.loadView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        setupNavTitle()
        setupTableView()
        let apiClient = ApiClient()
        apiClient.fetchCart(inputJson: "") { (entry, test) in
            self.productList = entry
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.rowHeight = 100
        tableView.estimatedRowHeight = 600
    }

    fileprivate func setupNavTitle(){
        navigationItem.title = "Products"
    }
    func setupTableView(){
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProductCell.self, forCellReuseIdentifier: cellId)
        setupAutoLayout()
    }


}

extension ViewController  {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ProductCell
        cell.loblowsProduct = productList[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productDetailVC = ProductDetailController()
        productDetailVC.entry = productList[indexPath.row]
        self.navigationController?.pushViewController(productDetailVC, animated: true)
    }

    func setupAutoLayout(){
        var constraints = [NSLayoutConstraint]()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        //MARK:- tableView
        constraints += [NSLayoutConstraint.init(item: tableView, attribute: .leading, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1.0, constant: 0.0)]
        constraints += [NSLayoutConstraint.init(item: tableView, attribute: .trailing, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1.0, constant: 0.0)]
        constraints += [NSLayoutConstraint.init(item: tableView, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1.0, constant: 0.0)]
        constraints += [NSLayoutConstraint.init(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: 0.0)]

        view.addConstraints(constraints)
    }

}

