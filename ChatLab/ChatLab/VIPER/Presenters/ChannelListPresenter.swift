//
//  ChannelListPresenter.swift
//  ChatLab
//
//  Created by Nestor Hernandez on 2/21/19.
//  Copyright © 2019 Nestor Hernandez. All rights reserved.
//

import UIKit
protocol ChannelListPresenterProtocol {
    
}
class ChannelListPresenter: ChannelListPresenterProtocol {
    private var modelLayer:ModelLayer
    
    init(modelLayer:ModelLayer) {
        self.modelLayer = modelLayer
    }
}
