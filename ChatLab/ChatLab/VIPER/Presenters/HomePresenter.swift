//
//  HomePresenter.swift
//  ChatLab
//
//  Created by Nestor Hernandez on 2/21/19.
//  Copyright © 2019 Nestor Hernandez. All rights reserved.
//

protocol HomePresenterProtocol {
    //*********  Inputs  ********* //
    func requestAccessAsGuest(completion: @escaping BlockBooleanResponse)
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
    func requestAccessAsGuest(completion: @escaping BlockBooleanResponse){
        modelLayer.doTwilioLogin(with: "Ness", completion: {(result, error) in
            completion(result, error)
        })
    }
}
