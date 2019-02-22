//
//  Constants.swift
//  ChatLab
//
//  Created by Nestor Hernandez on 2/21/19.
//  Copyright © 2019 Nestor Hernandez. All rights reserved.
//

import UIKit



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

enum AsycnResult: String {
    case success,
         error
}


struct Constants {
    struct BaseURL {
        static let base = "https://chat.twilio.com/v2"
        static let chat = "https://blush-bombay-7408.twil.io/chat-token"
    }
    struct Service {
        static let getToken = ""
    }
    
}
