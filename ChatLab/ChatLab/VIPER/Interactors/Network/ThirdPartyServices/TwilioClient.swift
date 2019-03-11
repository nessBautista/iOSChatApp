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
import RxCocoa



//MARK:- Twilio Chat Client Protocol
protocol TwilioClientProtocol {
    
    //*********  SDK chat client ********* //
    //var client: TwilioChatClient? {get set}
    //var generalChannel: TCHChannel? {get set}
    //var messages: [TCHMessage]  {get set}
    
    
    //*********  Inputs  ********* //
    func getToken(tokenRequest: TwilioLoginInfo, completion: @escaping BlockStringResponse)
    func startChatClient(token: String, completion: @escaping BlockBooleanResponse)
    
    //*********  Outputs  ********* //
    var rxChannelList: BehaviorRelay<[TCHChannel]> {get set}
    
    
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
    fileprivate var client: TwilioChatClient?
    
    //Protocol Variables
    var rxChannelList = BehaviorRelay<[TCHChannel]>(value: [])
    
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
            } else {
                let customError = CustomError(userMessage: "Error while starting twilio client", layer: .networkLayer, code: result.error?.code ?? 0)
                completion(false, customError)
            }            
        }
    }
    
    
    func chatClient(_ client: TwilioChatClient, synchronizationStatusUpdated status: TCHClientSynchronizationStatus) {
        if status == .completed {
            if let channelList = self.client?.channelsList(){
                self.rxChannelList.accept(channelList.subscribedChannels())
            }
        }
        if status == .channelsListCompleted {
                        
        }
    }
    
    func chatClient(_ client: TwilioChatClient, channel: TCHChannel, messageAdded message: TCHMessage) {
        
    }
    
    func onChannelListAvailable(channelList: TCHChannels){
        
    }
    
    
    //MARK:- Utilities
    func joinChannel(_ channelUniqueName: String){
        
    }       
}
