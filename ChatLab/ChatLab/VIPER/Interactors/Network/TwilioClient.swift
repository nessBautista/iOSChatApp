//
//  TwilioClient.swift
//  ChatLab
//
//  Created by Nestor Hernandez on 2/20/19.
//  Copyright © 2019 Nestor Hernandez. All rights reserved.
//

//MARK: COMMENTS
/*
    This class will manage the interaction with the Twilio Chat SDK
 */

import UIKit
import TwilioChatClient

//MARK:- Twilio Chat Client Protocol
protocol TwilioClientProtocol {
    //--- CHANNELS
    //[https://www.twilio.com/docs/chat/rest/channels]
    
    //List All Channels
    
    //Create a Channel
    
    //Retrieve a Channel
    
    //Channel SID
    
    //--- MESSAGES
    //[https://www.twilio.com/docs/chat/rest/messages]
    
    //List all messages in a channel
    
    //Send a Message to a Channel
    
    //Retrieve a Message from a Channel
    
    //Delete a Message from a Channel
    
    //--- ROLES
    //[https://www.twilio.com/docs/chat/rest/roles]
    //List All Roles
    
}

//MARK:- Twilio Chat Client Implementation
class TwilioClient: NSObject, TwilioClientProtocol {

}
