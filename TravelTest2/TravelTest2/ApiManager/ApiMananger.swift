//
//  ApiMananger.swift
//  TravelTest2
//
//  Created by 한석희 on 1/16/21.
//

import Foundation
import Alamofire


//MARK:- Login Error Enum & CompletionHandler
enum APIErrors : Error {
    case custom(message: String)
}
typealias Handler  = (Swift.Result<Any?, APIErrors>) -> Void
//


class ApiMananger {
    
    static let sharedInstance = ApiMananger()
    
    //MARK:- Calling Register API
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
                        //MARK:- Hand over json msg ex). already exist
                        let string = (json as? AnyObject)?.value(forKey: "message") as? String
                        completionHandler(false,  string )
                    }
                } catch  {
                    print(error.localizedDescription)
                    completionHandler(false,  "please try again" )
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                completionHandler(false,  "please try again" )
            }
            
        }
    }
    
    //MARK:- Calling Login API
    func callingLoginAPI(login : LoginModel, completionHandler : @escaping Handler ){
        //
        let headers : HTTPHeaders = [
            .contentType("application/json")
        ]
        //
        AF.request(login_url, method: .post, parameters: login, encoder: JSONParameterEncoder.default, headers: headers).response{ response in
            //
            print("Debug print as follows : ")
            debugPrint(response)
            //
            switch response.result {
            case .success(let data):
                do {
                    let json = try JSONDecoder().decode( LoginResponseModel.self, from: data! )
                    print(json)
                    if response.response?.statusCode == 200 {
                        completionHandler(.success(json))
                    }else{
                        //MARK:- Hand over json msg ex). already exist
                        completionHandler(.failure( .custom(message: "please check your network connectivity.") ))
                    }
                } catch  {
                    print(error.localizedDescription)
                    completionHandler(.failure( .custom(message: "please try again.") ))
                }
            case .failure(let error):
                print(error.localizedDescription)
                completionHandler(.failure( .custom(message: "please try again.") ))
            }
            
        }
        
        //
    }
    
    //
}
