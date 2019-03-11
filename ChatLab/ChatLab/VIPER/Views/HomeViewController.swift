//
//  HomeViewController.swift
//  ChatLab
//
//  Created by Nestor Hernandez on 2/21/19.
//  Copyright © 2019 Nestor Hernandez. All rights reserved.
//

import UIKit
import PKHUD
class HomeViewController: UIViewController {
    
    weak var navigationCoordinator: NavigationCoordinatorProtocol?
    fileprivate var presenter: HomePresenterProtocol!
    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var btnSignup: UIButton!
    
    @IBOutlet weak var btnLogin: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func configure(with presenter:HomePresenterProtocol,
                   navigationCoordinator: NavigationCoordinatorProtocol) {
        print("HomeViewController configure")
        self.navigationCoordinator = navigationCoordinator
        self.presenter = presenter
    }
    
    
    @IBAction func doSingup(_ sender: Any) {
        
    }
    
    @IBAction func doLogin(_ sender: Any) {
        
    }
    
    @IBAction func doGuestAccess(_ sender: Any) {
        navigationCoordinator?.showLoadingHUD()
        presenter.requestAccessAsGuest { [weak self] (success, error) in
            self?.navigationCoordinator?.hideHUD()
            if success == true {
                self?.navigationCoordinator?.next(arguments: [:])
            } else {
                self?.navigationCoordinator?.showMessage(type: .error, message: "Not able to login")
            }
        }
    }
}
