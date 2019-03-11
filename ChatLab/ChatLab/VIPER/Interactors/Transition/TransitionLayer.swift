//
//  TransitionLayer.swift
//  ChatLab
//
//  Created by Nestor Hernandez on 2/20/19.
//  Copyright © 2019 Nestor Hernandez. All rights reserved.
//

//MARK:- NOTES
/* This Struct will provide utility methods for appropiate Data Format.
 It will Help the communication between layers
 */
import UIKit
import TwilioChatClient

protocol TransitionLayerProtocol {
    
    //Twilio Transitions
    func getTwilioChannelStruct(channel: TCHChannel)-> TwilioChannel
}

class TransitionLayer:  TransitionLayerProtocol {
    func getTwilioChannelStruct(channel: TCHChannel) -> TwilioChannel {
        let twChannel = TwilioChannel(channelName: channel.friendlyName ?? String(),
                                      dateCreated: channel.dateCreated ?? String())
        return twChannel
    }
    
}
