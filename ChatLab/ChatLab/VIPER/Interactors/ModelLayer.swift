//
//  ModelLayer.swift
//  ChatLab
//
//  Created by Nestor Hernandez on 2/20/19.
//  Copyright © 2019 Nestor Hernandez. All rights reserved.
//

import UIKit
protocol ModelLayerProtocol {
    func getToken(for userIdentity: String, result: @escaping BlockAsyncBooleanResult)
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
    func getToken(for userIdentity: String, result: @escaping BlockAsyncBooleanResult) {
        networkLayer.getAccessToken(for: userIdentity) { (token, identity, error) in
            if let token = token, let identity = identity {
                print("Write token: \(token) and identity:\(identity)to UserDefaults")
                result(.success)
            } else {
                result(.error)
            }
        }
    }
}
