//
//  TwilioClient.swift
//  ChatLab
//
//  Created by Nestor Hernandez on 2/20/19.
//  Copyright © 2019 Nestor Hernandez. All rights reserved.
//

//MARK: COMMENTS
/*
    Encapsulation of all interactions with Twilio SDK and REST API
 */

import UIKit
import TwilioChatClient
import SwiftyJSON



//MARK:- Twilio Chat Client Protocol
protocol TwilioClientProtocol {
    
    //*********  SDK chat client ********* //
    var client: TwilioChatClient? {get set}
    var generalChannel: TCHChannel? {get set}
    var messages: [TCHMessage]  {get set}
    
    func getToken(tokenRequest: TwilioLoginInfo, completion: @escaping BlockStringResponse)
    func startChatClient(token: String, completion: @escaping BlockBooleanResponse)
    
    //********* TWILIO REST API  ********* //
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


//MARK:- TwilioClient REST API Implementation
class TwilioClient: NSObject, TwilioClientProtocol {
    var generalChannel: TCHChannel?
    
    var messages: [TCHMessage]
    
    var client: TwilioChatClient?
    
    deinit {
        print("TwilioClient deinit")
    }
    override init() {
        print("TwilioClient initialization")
        self.client = nil
        self.generalChannel = nil
        self.messages = []
        
    }
}

//MARK:- TwilioChatClient SDK Implementation
extension TwilioClient: TwilioChatClientDelegate {
    
    func getToken(tokenRequest: TwilioLoginInfo, completion: @escaping BlockStringResponse) {
        
        AlamofirePort().twilioRequest(service: Constants.BaseURL.chat,
                                      methodType: .get,
                                      params: tokenRequest.getRequest()) { (responseData, error) in
                                       
                                        guard error == nil else {completion(nil, error) ;return}
                                        if let data = responseData {
                                            let token = (JSON(data)["token"].string)
                                           completion(token, nil)
                                        }
                                        
        }
    }
    
    func startChatClient(token: String, completion: @escaping BlockBooleanResponse) {
        TwilioChatClient.chatClient(withToken: token, properties: nil, delegate: self) {
            (result, chatClient) in
            if result.isSuccessful() == true {
                self.client = chatClient;
                print("Logged in")
                completion(true, nil)
            }
            completion(false, .badRequest)
    }
   
    
        
//        let deviceId = UIDevice.current.identifierForVendor!.uuidString
//        let urlString = "\(Constants.BaseURL.chat)?identity=\(userId)&device=\(deviceId)"
//
//        TokenUtils.retrieveToken(url: urlString) { (token, identity, error) in
//            if let token = token {
//                // Set up Twilio Chat client
//                TwilioChatClient.chatClient(withToken: token, properties: nil, delegate: self) {
//                    (result, chatClient) in
//                    self.client = chatClient;
//                    // Update UI on main thread
//                    DispatchQueue.main.async() {
//                        print("Logged in as \"\(identity ?? String())\"")
//                    }
//                    completion(token, identity, error)
//                }
//            } else {
//                print("Error retrieving token: \(error.debugDescription)")
//                completion(String(), String(), error)
//            }
//
//        }
//        AlamofirePort().testRequest { (json, error) in
//            if let netError = error {
//                print(netError)
//            }
//            if let jsonValue = json {
//                print(JSON(jsonValue))
//            }
//        }
        
    }
    
    func chatClient(_ client: TwilioChatClient, synchronizationStatusUpdated status: TCHClientSynchronizationStatus) {
        
    }
    
    func chatClient(_ client: TwilioChatClient, channel: TCHChannel, messageAdded message: TCHMessage) {
        
    }
}
