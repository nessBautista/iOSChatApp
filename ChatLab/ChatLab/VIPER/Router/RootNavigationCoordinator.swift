//
//  RootNavigationCoordinator.swift
//  ChatLab
//
//  Created by Nestor Hernandez on 2/20/19.
//  Copyright © 2019 Nestor Hernandez. All rights reserved.
//

import UIKit

protocol NavigationCoordinatorProtocol: class {
    func next(arguments: Dictionary<String, Any>?)
    func movingBack()
}

class NavigationCoordinator: NavigationCoordinatorProtocol {
    
    var registry: DependencyRegistryProtocol
    var rootViewController: UIViewController
    var navState: NavigationState = .home
    
    init(with rootViewController: UIViewController, registry: DependencyRegistry) {
        self.rootViewController = rootViewController
        self.registry = registry
    }
    
    func next(arguments: Dictionary<String, Any>?) {
        switch navState {
        case .home:
            showChannelList(arguments: arguments)
            
        case .channelList:
            break
        case .chat:
            break
        default:
            break
        }
    }
    
    func movingBack() {
        
    }
    
    func showChannelList(arguments: Dictionary<String, Any>?) {
        //guard let spy = arguments?["spy"] as? SpyDTO else { notifyNilArguments(); return }
        
//        let channelListVC = registry.makeDetailViewController(with: spy)
//
//        rootViewController.navigationController?.pushViewController(detailViewController, animated: true)
//        navState = .atSpyDetails
    }
    
}
