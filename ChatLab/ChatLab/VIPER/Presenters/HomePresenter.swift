//
//  HomePresenter.swift
//  ChatLab
//
//  Created by Nestor Hernandez on 2/21/19.
//  Copyright © 2019 Nestor Hernandez. All rights reserved.
//

import UIKit


protocol HomePresenterProtocol {
    func requestAccessAsGuest(result: @escaping BlockAsyncBooleanResult)
}

class HomePresenter: HomePresenterProtocol {
    fileprivate var modelLayer: ModelLayerProtocol
    
    deinit {
        print("HomePresenter deinit")
    }
    init(modelLayer: ModelLayerProtocol) {
        print("HomePresenter initialization")
        self.modelLayer = modelLayer
    }
}

//MARK:- Login Functions
extension HomePresenter {
    func requestAccessAsGuest(result: @escaping BlockAsyncBooleanResult){        
        modelLayer.doTwilioLogin(with: "Ness")
    }
}
