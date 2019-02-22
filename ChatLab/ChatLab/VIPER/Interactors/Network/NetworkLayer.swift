//
//  NetworkLayer.swift
//  ChatLab
//
//  Created by Nestor Hernandez on 2/20/19.
//  Copyright © 2019 Nestor Hernandez. All rights reserved.
//

import UIKit

protocol NetworkLayerProtocol {
    func getAccessToken(for userId:String, onComplete: @escaping (_ token: String?, _ identity: String?, _ error: Error?) -> Void)
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
    
    func getAccessToken(for userId:String, onComplete: @escaping (_ token: String?, _ identity: String?, _ error: Error?) -> Void) {
        twilioClient.doChatLogin(for: userId) { (token, identity, error) in
            onComplete(token, identity, error)
        }
        
    }
}
