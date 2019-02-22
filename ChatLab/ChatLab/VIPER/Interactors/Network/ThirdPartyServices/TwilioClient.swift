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




//MARK:- Twilio Chat Client Protocol
protocol TwilioClientProtocol {
    
    //*********  SDK chat client ********* //
    var client: TwilioChatClient? {get set}
    
    func doChatLogin(for userId:String, completion: @escaping (_ token: String?, _ identity: String?, _ error: Error?) -> Void)
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
    var client: TwilioChatClient?
    
    deinit {
        print("TwilioClient deinit")
    }
    override init() {
        print("TwilioClient initialization")
        self.client = nil
    }
    
    
    
}

//MARK:- TwilioChatClient SDK Implementation
extension TwilioClient: TwilioChatClientDelegate {
    
    //Login
    func doChatLogin(for userId:String, completion: @escaping (_ token:String?, _ identity: String?, _ error:Error?) -> Void) {
        
        let deviceId = UIDevice.current.identifierForVendor!.uuidString
        let urlString = "\(Constants.BaseURL.chat)?identity=\(userId)&device=\(deviceId)"
        
        TokenUtils.retrieveToken(url: urlString) { (token, identity, error) in
            if let token = token {
                // Set up Twilio Chat client
                TwilioChatClient.chatClient(withToken: token, properties: nil, delegate: self) {
                    (result, chatClient) in
                    self.client = chatClient;
                    // Update UI on main thread
                    DispatchQueue.main.async() {
                        print("Logged in as \"\(identity ?? String())\"")
                    }
                    completion(token, identity, error)
                }
            } else {
                print("Error retrieving token: \(error.debugDescription)")
                completion(String(), String(), error)
            }
            
        }
    }
    
    func chatClient(_ client: TwilioChatClient, synchronizationStatusUpdated status: TCHClientSynchronizationStatus) {
        
    }
    
    func chatClient(_ client: TwilioChatClient, channel: TCHChannel, messageAdded message: TCHMessage) {
        
    }
}


struct TokenUtils {
    
    static func retrieveToken(url: String, completion: @escaping (String?, String?, Error?) -> Void) {
        if let requestURL = URL(string: url) {
            let session = URLSession(configuration: URLSessionConfiguration.default)
            let task = session.dataTask(with: requestURL, completionHandler: { (data, response, error) in
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String:String]
                        let token = json["token"]
                        let identity = json["identity"]
                        completion(token, identity, error)
                    }
                    catch let error as NSError {
                        completion(nil, nil, error)
                    }
                    
                } else {
                    completion(nil, nil, error)
                }
            })
            task.resume()
        }
        
    }
}
