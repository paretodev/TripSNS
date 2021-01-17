//
//  ApiMananger.swift
//  TravelTest2
//
//  Created by 한석희 on 1/16/21.
//

import Foundation
import Alamofire


class ApiMananger {
    
    static let sharedInstance = ApiMananger()
    
    func callingRegisterAPI(register : RegisterModel, completionHandler : @escaping (Bool, String?) -> () ){
        
        let headers : HTTPHeaders = [
            .contentType("application/json")
        ]
        
        AF.request(register_url, method: .post, parameters: register, encoder: JSONParameterEncoder.default, headers: headers).response{ response in
            
            print("Debug print as follows : ")
            debugPrint(response)
            
            switch response.result {
            
            case .success(let data):
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    print("json printing ...\n", json)
                    if response.response?.statusCode == 200 {
                        completionHandler(true, nil)
                    }else{
                        let string = (json as? AnyObject)?.value(forKey: "message") as? String
                        completionHandler(false,  string )
                    }
                } catch  {
                    print(error.localizedDescription)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    //
}
