//
//  AppDelegate.swift
//  FioTestApp
//
//  Created by George Ivannikov on 10.07.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var mainCoordinator: MainCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let navigationController = UINavigationController()
        window? = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = navigationController
        mainCoordinator = MainCoordinator(navigationController: navigationController)
        mainCoordinator?.start()
        return true
    }
}
