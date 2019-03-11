//
//  Constants.swift
//  ChatLab
//
//  Created by Nestor Hernandez on 2/21/19.
//  Copyright © 2019 Nestor Hernandez. All rights reserved.
//

import UIKit
import SwiftyJSON


//MARK:- Navigation Enums
enum NavigationState {
    case home,
         channelList,
         chat
}

enum ModalType {
    case newChannel
}

enum RegistrationState {
    case success,
         error
}

//MARK:- Network layer



typealias BlockNetworkResponse = (_ response:Any?, _ error: CustomError?)->()
typealias BlockStringResponse = (_ response:String?, _ error: CustomError?)->()
typealias BlockJsonResponse = (_ jsonData: JSON?, _ error: CustomError?)->()
typealias BlockBooleanResponse = (_ response: Bool?, _ error: CustomError?)->()
//typealias BlockTwilioChannelResponse = (_ channel: TCHChannel?, )


enum AsycnResult: String {
    case success,
         error
}

enum NetworkLayerError: Error {
    case canceledRequest
    case httpError(code: Int)
    case badRequest
}

enum AppLayer: Int {
    case modelLayer
    case networkLayer
    case transferLayer
}

struct CustomError: Error {
    var userMessage: String
    var layer: AppLayer
    var code: Int
    init(userMessage: String, layer: AppLayer, code: Int){
        self.userMessage = userMessage
        self.layer = layer
        self.code = code
    }
}

struct Constants {
    static let defaultChannel = "general"
    
    struct BaseURL {
        static let base = "https://chat.twilio.com/v2"
        static let chat = "https://blush-bombay-7408.twil.io/chat-token"
    }
    struct Service {
        static let getToken = ""
    }
    
}
