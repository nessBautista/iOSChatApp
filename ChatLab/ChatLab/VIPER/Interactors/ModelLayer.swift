//
//  ModelLayer.swift
//  ChatLab
//
//  Created by Nestor Hernandez on 2/20/19.
//  Copyright © 2019 Nestor Hernandez. All rights reserved.
//

import UIKit
protocol ModelLayerProtocol {    
    func doTwilioLogin(with userIdentity: String)
}

class ModelLayer: ModelLayerProtocol {
    var networkLayer: NetworkLayerProtocol
    
    deinit {
        print("ModelLayer deinit")
    }
    init(networkLayer: NetworkLayerProtocol) {
        print("ModelLayer initialization")
        self.networkLayer = networkLayer
    }
}
//MARK:- Login Functions
extension ModelLayer {
    
    func doTwilioLogin(with userIdentity: String) {
        networkLayer.twilioLogin(with: userIdentity)
    }
}
