//
//  RootNavigationCoordinator.swift
//  ChatLab
//
//  Created by Nestor Hernandez on 2/20/19.
//  Copyright © 2019 Nestor Hernandez. All rights reserved.
//

import UIKit
import PKHUD

protocol NavigationCoordinatorProtocol: class {
    func next(arguments: Dictionary<String, Any>?)
    func presentModalController(arguments: Dictionary<String, Any>?)
    func movingBack()
    func showLoadingHUD()
    func hideHUD()
    func showMessage(type: MessageType, message: String)
    
}

class NavigationCoordinator: NavigationCoordinatorProtocol {
    
    var registry: DependencyRegistryProtocol
    var rootViewController: UIViewController
    var navState: NavigationState = .home
    private var hud: PKHUD = PKHUD.sharedHUD
    
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
        }
    }
    
    func movingBack() {
        switch navState {
        case .home:
            break
            
        case .channelList:
            navState = .home
        case .chat:
            break
        }
    }
    
    func showChannelList(arguments: Dictionary<String, Any>?) {
        
        let channelListVC = registry.makeChannelListController()
        rootViewController.navigationController?.pushViewController(channelListVC, animated: true)
        navState = .channelList
    }
    
    func presentModalController(arguments: Dictionary<String, Any>?) {
        if let modalType = arguments?["type"] as? ModalType {
            switch modalType {
            case .newChannel:
                let vcNewChannel = registry.makeNewChannelViewController()                
                rootViewController.navigationController?.present(vcNewChannel, animated: true, completion: nil)
                break
            
            }
        }
    }
    
    func showLoadingHUD(){
        self.hud.contentView = PKHUDProgressView()
        self.hud.show()
    }
    
    func hideHUD(){
        self.hud.hide()
    }
}

enum MessageType {
    case success
    case warning
    case error
}

extension NavigationCoordinator {
    func showMessage(type: MessageType, message: String) {
        
    }
}
