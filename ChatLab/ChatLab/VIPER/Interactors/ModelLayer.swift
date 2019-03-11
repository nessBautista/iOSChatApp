//
//  ModelLayer.swift
//  ChatLab
//
//  Created by Nestor Hernandez on 2/20/19.
//  Copyright © 2019 Nestor Hernandez. All rights reserved.
//


import RxCocoa
import  RxSwift

typealias BlockTwilioChannelsResponse = (_ response: [TwilioChannel]?, _ error: CustomError?)->()

protocol ModelLayerProtocol {
    //*********  Inputs  ********* //
    func doTwilioLogin(with userIdentity: String, completion: @escaping BlockBooleanResponse)
    
    //*********  Outputs  ********* //
    var rxChannelList: BehaviorRelay<[TwilioChannel]> {get set}    
}

class ModelLayer: ModelLayerProtocol {
    var networkLayer: NetworkLayerProtocol
    var transitionLayer: TransitionLayerProtocol
    var rxChannelList = BehaviorRelay<[TwilioChannel]>(value:[])
    var bag = DisposeBag()
    deinit {
        print("ModelLayer deinit")
    }
    
    init(networkLayer: NetworkLayerProtocol, transitionLayer: TransitionLayerProtocol) {
        print("ModelLayer initialization")
        self.networkLayer = networkLayer
        self.transitionLayer = transitionLayer
        self.bindData()
    }
    
    func bindData(){
        networkLayer.rxChannelList.asObservable().bind { [weak self] (channels) in
            guard let strongSelf = self else {return}
            let twChannels = channels.map({ (strongSelf.transitionLayer.getTwilioChannelStruct(channel: $0))})
            strongSelf.rxChannelList.accept(twChannels)
        }.disposed(by: bag)
    }
}
//MARK:- Login Functions
extension ModelLayer {
    
    func doTwilioLogin(with userIdentity: String, completion: @escaping BlockBooleanResponse) {
        networkLayer.twilioLogin(with: userIdentity, completion: { (result, error) in
            completion(result, error)
        })
    }
}

