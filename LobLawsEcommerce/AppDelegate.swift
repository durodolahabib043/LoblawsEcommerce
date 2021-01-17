//
//  AppDelegate.swift
//  LobLawsEcommerce
//
//  Created by Habib Durodola on 2021-01-14.
//

import UIKit


class CommonNavigationContoller : UINavigationController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var windows: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        windows = UIWindow()
        windows?.makeKeyAndVisible()

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        windows?.rootViewController = CommonNavigationContoller(rootViewController: HomeController(collectionViewLayout: layout))
        return true
    }

}

