//
//  SwinjectStoryboard+Extensions.swift
//  ChatLab
//
//  Created by Nestor Hernandez on 2/20/19.
//  Copyright © 2019 Nestor Hernandez. All rights reserved.
//

import UIKit
import Swinject
import SwinjectStoryboard

extension SwinjectStoryboard {
    public class func setup() {
        
        if AppDelegate.dependencyRegistry == nil {
            AppDelegate.dependencyRegistry = DependencyRegistry(container: defaultContainer)
        }
        let dependencyRegistry: DependencyRegistryProtocol = AppDelegate.dependencyRegistry
        
        func main() {
            dependencyRegistry.container.storyboardInitCompleted(HomeViewController.self, initCompleted: {
                resolver, vc in
                let coordinator = dependencyRegistry.makeRootNavigationCoordinator(rootViewController: vc)
                setupData(resolver: resolver, navigationCoordinator: coordinator)
                let presenter = resolver.resolve(HomePresenterProtocol.self)!
                
                
                //Requires method injection (we don't have access to the controller's init)
                vc.configure(with: presenter, navigationCoordinator: coordinator)
            })
        }
        
        func setupData(resolver r: Resolver, navigationCoordinator: NavigationCoordinatorProtocol) {
            
            AppDelegate.navigationCoordinator = navigationCoordinator
        }
        
        main()
    }
}
