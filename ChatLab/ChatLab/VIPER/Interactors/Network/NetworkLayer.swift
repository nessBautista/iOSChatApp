//
//  NetworkLayer.swift
//  ChatLab
//
//  Created by Nestor Hernandez on 2/20/19.
//  Copyright © 2019 Nestor Hernandez. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import TwilioChatClient

protocol NetworkLayerProtocol {
    
    //*********  Inputs  ********* //
    func twilioLogin(with User: String, completion:@escaping BlockBooleanResponse)
    
    //*********  Outputs  ********* //
    var rxChannelList: BehaviorRelay<[TCHChannel]> {get set}
    
}
class NetworkLayer: NetworkLayerProtocol {
    fileprivate var twilioClient: TwilioClientProtocol
    var rxChannelList = BehaviorRelay<[TCHChannel]>(value:[])
    var bag = DisposeBag()
    deinit {
        print("NetworkLayer deinit")
    }
    init(twilioClient: TwilioClientProtocol) {
        print("NetworkLayer initialization")
        self.twilioClient = twilioClient
        self.bindData()
    }
    
    fileprivate func bindData(){
        self.twilioClient.rxChannelList.asObservable().bind{ [weak self] (channels) in
            self?.rxChannelList.accept(channels)
        }.disposed(by: bag)
    }
}

//MARK:- Login Functions
extension NetworkLayer {
    
    func twilioLogin(with userIdentity: String, completion:@escaping BlockBooleanResponse) {
        twilioClient.getToken(tokenRequest: TwilioLoginInfo(identity: userIdentity)) { [weak self] (token, error) in
            guard error == nil else {
                
                completion(false, error)
                return
            }
            if let accesstoken = token {
                print(accesstoken)
                self?.twilioClient.startChatClient(token: accesstoken, completion: { (response, error) in
                    print("success")
                    completion(true, nil)
                })
            }
        }
    }        
}


