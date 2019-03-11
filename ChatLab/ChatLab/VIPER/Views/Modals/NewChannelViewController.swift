//
//  NewChannelViewController.swift
//  ChatLab
//
//  Created by Nestor Hernandez on 3/5/19.
//  Copyright © 2019 Nestor Hernandez. All rights reserved.
//

import UIKit

class NewChannelViewController: UIViewController {
    
    
    @IBOutlet weak var btnCreateChannel: UIButton!
    fileprivate weak var navigationCoordinator: NavigationCoordinatorProtocol?
    
    init(with navigationCoordinator: NavigationCoordinatorProtocol) {
        self.navigationCoordinator = navigationCoordinator
        super.init(nibName: "NewChannelViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
    }

    
    @IBAction func createChannel(_ sender: Any) {
    }
    


}
