//
//  TwilioChatStructs.swift
//  ChatLab
//
//  Created by Nestor Hernandez on 2/22/19.
//  Copyright © 2019 Nestor Hernandez. All rights reserved.
//

import UIKit

struct TwilioLoginInfo {
    var identity:String
    var deviceID: String {
        return UIDevice.current.identifierForVendor!.uuidString
    }
    var token:String
    
    init(identity:String) {
        self.identity = identity
        self.token = String()
    }
    
    func getRequest()->[String: Any] {
        var dict:[String:Any] = [:]
        dict["identity"] = identity
        dict["device"] = deviceID
        return dict
    }
}

