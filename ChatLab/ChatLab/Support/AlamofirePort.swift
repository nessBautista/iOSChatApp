//
//  AlamofirePort.swift
//  ChatLab
//
//  Created by Nestor Hernandez on 2/22/19.
//  Copyright © 2019 Nestor Hernandez. All rights reserved.
//

import UIKit
import Alamofire

protocol AlamofirePortable {
    func testRequest(completion: @escaping BlockNetworkResponse)
    func responseValidation(response: DataResponse<Any>)-> CustomError?
}
struct AlamofirePort: AlamofirePortable {
    
    func testRequest(completion: @escaping BlockNetworkResponse)  {
        Alamofire.request("https://httpbin.org/get").responseJSON { response in
            
            guard let statusCode = response.response?.statusCode else {
                let error = CustomError(userMessage: "Error from httpbin.org", layer: .networkLayer, code: 0)
                completion(nil, error)
                return
            }
            guard statusCode == 200 else {
                let error = CustomError(userMessage: "Error from httpbin.org", layer: .networkLayer, code: statusCode)
                completion(nil,error)
                return
            }
            
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }

            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
                completion(data, nil)
            }
        }
    }
    
    func twilioRequest(service:String, methodType: Alamofire.HTTPMethod, params:[String:Any]?, completion: @escaping BlockNetworkResponse) {
        
        guard let url = URL(string: service) else {
            let error = CustomError(userMessage: "There's something wrong with the URL format",
                                    layer: .networkLayer, code: 0)
            completion(nil, error);
            return
        }
        
        Alamofire.request(url, method: methodType, parameters: params, encoding: URLEncoding.default, headers: nil)
                 .responseJSON { (response) in
            
                    if let error = self.responseValidation(response: response) {
                        completion(nil, error); return
                    }
                    if let jsonValue = response.result.value {
                        completion(jsonValue, nil)
                    }
        }
    }
    
    func responseValidation(response: DataResponse<Any>)-> CustomError? {
        guard let statusCode = response.response?.statusCode else {
            let error = CustomError(userMessage:"Bad network request",
                                    layer:.networkLayer,
                                    code: 0)
            return error
            
        }
        guard statusCode == 200 else {
            let error = CustomError(userMessage:"Error from Http request. Code: \(statusCode)",
                                    layer:.networkLayer,
                                    code: statusCode)
            return error
        }
        return nil
    }
}

