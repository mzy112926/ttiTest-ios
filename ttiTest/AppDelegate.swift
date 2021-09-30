//
//  AppDelegate.swift
//  ttiTest
//
//  Created by iOS-马振宇 on 2021/9/28.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.main.bounds)
        let nav = UINavigationController(rootViewController: ViewController())
        self.window?.rootViewController = nav
        self.window?.makeKeyAndVisible()
        
        return true
    }


}

