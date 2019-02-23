//
//  NetworkLayer.swift
//  ChatLab
//
//  Created by Nestor Hernandez on 2/20/19.
//  Copyright © 2019 Nestor Hernandez. All rights reserved.
//

import UIKit

protocol NetworkLayerProtocol {    
    func twilioLogin(with User: String)
}
class NetworkLayer: NetworkLayerProtocol {
    fileprivate var twilioClient: TwilioClientProtocol
    
    deinit {
        print("NetworkLayer deinit")
    }
    init(twilioClient: TwilioClientProtocol) {
        print("NetworkLayer initialization")
        self.twilioClient = twilioClient
    }
}

//MARK:- Login Functions
extension NetworkLayer {
    

    
    func twilioLogin(with userIdentity: String) {
        twilioClient.getToken(tokenRequest: TwilioLoginInfo(identity: userIdentity)) { [weak self] (token, error) in
            guard error == nil else {return}
            if let accesstoken = token {
                print(accesstoken)
                self?.twilioClient.startChatClient(token: accesstoken, completion: { (response, error) in
                    print("success")
                })
                
            }
        }
    }
}
