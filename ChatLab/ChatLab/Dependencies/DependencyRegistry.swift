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
//
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
        
        
        //-- INTERACTOR
        container.register(ModelLayerProtocol.self) {r in
            ModelLayer(networkLayer: r.resolve(NetworkLayerProtocol.self)!)
        }.inObjectScope(.container)
    }
    
    func registerPresenters() {
        container.register(HomePresenterProtocol.self) { r in HomePresenter(modelLayer:r.resolve(ModelLayerProtocol.self)!)}
        
    }
    
    func registerViewControllers() {
        
    }
    
    //MARK: - Maker Methods
    func makeRootNavigationCoordinator(rootViewController: UIViewController) -> NavigationCoordinatorProtocol {
        navigationCoordinator = container.resolve(NavigationCoordinatorProtocol.self, argument: rootViewController)!
        return navigationCoordinator
    }
}
