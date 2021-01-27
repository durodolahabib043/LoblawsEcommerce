//
//  ProductHeaderView.swift
//  LobLawsEcommerce
//
//  Created by Habib Durodola on 2021-01-25.
//

import UIKit

class ProductHeaderView: UICollectionReusableView  {


    var safeArea: UILayoutGuide!
    lazy var searchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search Me"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()

    func addAutoLayout(){

        var constraints = [NSLayoutConstraint]()
        safeArea = safeAreaLayoutGuide
        // MARK:- searchBar
        constraints += [NSLayoutConstraint.init(item: searchBar, attribute: .leading, relatedBy: .equal, toItem: safeArea, attribute: .leading, multiplier: 1.0, constant: 0.0)]
        // trailing fullStackView
        constraints += [NSLayoutConstraint.init(item: searchBar, attribute: .trailing, relatedBy: .equal, toItem: safeArea, attribute: .trailing, multiplier: 1.0, constant: 0.0)]
        constraints += [NSLayoutConstraint.init(item: searchBar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50.0)]
        addConstraints(constraints)
        
    }
    func setupViews() {
        addSubview(searchBar)
        addAutoLayout()


    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
