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
    override func loadView() {
        super.loadView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        setupNavTitle()
        setupTableView()
        //        let apiClient = ApiClient()
        //        apiClient.fetchCart(inputJson: "") { (entry, test) in
        //            print("This is sample entry \(entry[0].name)")
        //        }
    }

    fileprivate func setupNavTitle(){
        navigationItem.title = "Products"
    }
    func setupTableView(){
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        setupAutoLayout()
    }


}

extension ViewController  {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = "sample"
        return cell
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

