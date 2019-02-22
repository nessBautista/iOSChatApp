//
//  HomeViewController.swift
//  ChatLab
//
//  Created by Nestor Hernandez on 2/21/19.
//  Copyright © 2019 Nestor Hernandez. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    weak var navigationCoordinator: NavigationCoordinatorProtocol?
    fileprivate var presenter: HomePresenterProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func configure(with presenter:HomePresenterProtocol,
                   navigationCoordinator: NavigationCoordinatorProtocol){
        print("HomeViewController configure")
        self.navigationCoordinator = navigationCoordinator
        self.presenter = presenter
    }
    
    
    @IBAction func doGuestAccess(_ sender: Any) {
        presenter.requestAccessAsGuest { [weak self] (result) in            
            guard result == .success else { return }
            self?.navigationCoordinator?.next(arguments: [:])
        }
        
    }
}
