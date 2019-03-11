//
//  ChannelListPresenter.swift
//  ChatLab
//
//  Created by Nestor Hernandez on 2/21/19.
//  Copyright © 2019 Nestor Hernandez. All rights reserved.
//
import RxSwift
import RxCocoa
import RxDataSources

struct ChannelSection {
    var header: String
    var items: [Item]
}

extension ChannelSection: SectionModelType {
    typealias Item = TwilioChannel
    
    init(original: ChannelSection, items: [Item]) {
        self = original
        self.items = items
    }
}

protocol ChannelListPresenterProtocol {
    
    //*********  Inputs  ********* //
    func createNewChannel(_ channel: TwilioChannel)
    //*********  Outputs  ********* //
    var channelSections: BehaviorRelay<[ChannelSection]> {get}
}

class ChannelListPresenter: ChannelListPresenterProtocol {
    private var modelLayer:ModelLayerProtocol
    var channelSections = BehaviorRelay<[ChannelSection]>(value:[])        // Exposed to ViewController
    fileprivate var channels = BehaviorRelay<[TwilioChannel]>(value:[])
    fileprivate var bag = DisposeBag()
    init(modelLayer:ModelLayerProtocol) {
        self.modelLayer = modelLayer
        self.bindData()
    }
}

//MARK:- Protocol Implementation
extension ChannelListPresenter {
    func createNewChannel(_ channel: TwilioChannel){
        
    }
}
//MARK:- Rx Bindings
extension ChannelListPresenter {
    func bindData(){
        //Presenter <------ Model Layer
        self.modelLayer.rxChannelList.asObservable().bind { [weak self](channels) in
            self?.channels.accept(channels)
            }.disposed(by: bag)
        
        // ViewController <------ Presenter
        channels.asObservable().subscribe(onNext: { [weak self] (channels) in
            self?.broadcastChannelInfo(channels)
        }).disposed(by: self.bag)
    }
    
    func broadcastChannelInfo(_ channels: [TwilioChannel]){
        let channelListSection = [ChannelSection(header: "Channel List", items: channels)]
        channelSections.accept(channelListSection)
    }
}


