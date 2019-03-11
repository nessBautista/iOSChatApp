//
//  DependencyRegistry.swift
//  ChatLab
//
//  Created by Nestor Hernandez on 2/20/19.
//  Copyright © 2019 Nestor Hernandez. All rights reserved.
//

import UIKit
import Swinject
import SwinjectStoryboard

protocol DependencyRegistryProtocol {
    var container: Container { get }
    var navigationCoordinator: NavigationCoordinatorProtocol! { get }
    
    typealias rootNavigationCoordinatorMaker = (UIViewController) -> NavigationCoordinatorProtocol
    func makeRootNavigationCoordinator(rootViewController: UIViewController) -> NavigationCoordinatorProtocol
    
    typealias ChannelListMaker = () -> ChannelListViewController
    func makeChannelListController() -> ChannelListViewController

    typealias NewChannelViewControllerMaker = () -> NewChannelViewController
    func makeNewChannelViewController()-> NewChannelViewController
//    typealias SpyCellMaker = (UITableView, IndexPath, SpyDTO) -> SpyCell
//    func makeSpyCell(for tableView: UITableView, at indexPath: IndexPath, with spy: SpyDTO) -> SpyCell
//
//    typealias DetailViewControllerMaker = (SpyDTO) -> DetailViewController
//    func makeDetailViewController(with spy: SpyDTO) -> DetailViewController
//
//    typealias SecretDetailsViewControllerMaker = (SpyDTO)  -> SecretDetailsViewController
//    func makeSecretDetailsViewController(with spy: SpyDTO) -> SecretDetailsViewController
}
class DependencyRegistry: DependencyRegistryProtocol {
    var container: Container
    var navigationCoordinator: NavigationCoordinatorProtocol!
    
    init(container: Container) {
        Container.loggingFunction = nil
        self.container = container
        self.registerDependencies()
        self.registerPresenters()
        self.registerViewControllers()
    }

    
    func registerDependencies() {
        container.register(NavigationCoordinatorProtocol.self) { (r, rootViewController: UIViewController) in
            return NavigationCoordinator(with: rootViewController, registry: self)
            }.inObjectScope(.container)
        
        //Low level classes
        container.register(TwilioClientProtocol.self){_ in TwilioClient()}.inObjectScope(.container)
        
        //Network Layer
        container.register(NetworkLayerProtocol.self) { r in
            NetworkLayer(twilioClient: r.resolve(TwilioClientProtocol.self)!)
        }.inObjectScope(.container)
        
        //Data Layer
        container.register(DataLayerProtocol.self){_ in DataLayer()}.inObjectScope(.container)
        
        //Transition Layer
        container.register(TransitionLayerProtocol.self) {_ in TransitionLayer()}.inObjectScope(.container)
        
        //-- INTERACTOR
        container.register(ModelLayerProtocol.self) { r in
            ModelLayer(networkLayer: r.resolve(NetworkLayerProtocol.self)!,
                       transitionLayer: r.resolve(TransitionLayerProtocol.self)!)
        }.inObjectScope(.container)
    }
    
    func registerPresenters() {
        container.register(HomePresenterProtocol.self) { r in HomePresenter(modelLayer:r.resolve(ModelLayerProtocol.self)!)}
        container.register(ChannelListPresenterProtocol.self) { r in ChannelListPresenter(modelLayer: r.resolve(ModelLayerProtocol.self)!)}
        
    }
    
    func registerViewControllers() {
        container.register(ChannelListViewController.self) { (r) in
            let presenter = r.resolve(ChannelListPresenterProtocol.self)!
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChannelListViewController") as! ChannelListViewController
            vc.configure(with: presenter, navigationCoordinator: self.navigationCoordinator)
            return vc
        }
        
        container.register(NewChannelViewController.self) { r in
            
            return NewChannelViewController(with: self.navigationCoordinator)
        }
    }
    
    //MARK: - Maker Methods
    func makeRootNavigationCoordinator(rootViewController: UIViewController) -> NavigationCoordinatorProtocol {
        navigationCoordinator = container.resolve(NavigationCoordinatorProtocol.self, argument: rootViewController)!
        return navigationCoordinator
    }
    
    func makeChannelListController() -> ChannelListViewController {
        return container.resolve(ChannelListViewController.self)!
    }
    
    func makeNewChannelViewController()-> NewChannelViewController {
        return container.resolve(NewChannelViewController.self)!
    }
}
