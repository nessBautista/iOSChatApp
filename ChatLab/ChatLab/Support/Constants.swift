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

enum RegistrationState {
    case success,
         error
}

//MARK:- Network layer

typealias BlockAsyncBooleanResult = (AsycnResult)->()

typealias BlockNetworkResponse = (_ response:Any?, _ error: NetworkLayerError?)->()
typealias BlockStringResponse = (_ response:String?, _ error: NetworkLayerError?)->()
typealias BlockJsonResponse = (_ jsonData: JSON?, _ error: NetworkLayerError?)->()
typealias BlockBooleanResponse = (_ response: Bool?, _ error: NetworkLayerError?)->()
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
