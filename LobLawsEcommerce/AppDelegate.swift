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
        windows?.rootViewController = UINavigationController(rootViewController: ViewController())
        return true
    }

}

