//
//  AppDelegate.swift
//  LobLawsEcommerce
//
//  Created by Habib Durodola on 2021-01-14.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var windows: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        windows = UIWindow()
        windows?.makeKeyAndVisible()

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        windows?.rootViewController = UINavigationController(rootViewController: HomeController(collectionViewLayout: layout))
        return true
    }

}

