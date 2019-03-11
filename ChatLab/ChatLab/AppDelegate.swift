//
//  AppDelegate.swift
//  ChatLab
//
//  Created by Nestor Hernandez on 2/20/19.
//  Copyright © 2019 Nestor Hernandez. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    static var navigationCoordinator: NavigationCoordinatorProtocol!
    static var dependencyRegistry: DependencyRegistryProtocol!

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        return true
    }
}

