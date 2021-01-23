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

class ApiMananger {
    //MARK:- Static Var
    static let sharedInstance = ApiMananger()
    //MARK:- Calling Register API
    func callingRegisterAPI(register : RegisterModel, completionHandler : @escaping (Bool, String?) -> () ){
        let headers : HTTPHeaders = [
            .contentType("application/json")
        ]
        AF.request(register_url, method: .post, parameters: register, encoder: JSONParameterEncoder.default, headers: headers).response{ response in
            
            switch response.result {
            
            case .success(let data):
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    //MARK:- 등록 성공
                    if response.response?.statusCode == 200 {
                        completionHandler(true, nil)
                    }else{
                        //MARK:- 이미 등록된 아이디
                        let string = (json as AnyObject).value(forKey: "message") as? String
                        completionHandler(false,  string )
                    }
                } catch  {
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
        let headers : HTTPHeaders = [
            .contentType("application/json")
        ]
        AF.request(login_url, method: .post, parameters: login, encoder: JSONParameterEncoder.default, headers: headers).response{ response in
            switch response.result {
            case .success(let data):
                do {
                    let json = try JSONDecoder().decode( LoginResponseModel.self, from: data! )
                    if response.response?.statusCode == 200 {
                        completionHandler(.success(json))
                    }else{
                        //MARK:- Hand over json msg
                        completionHandler(.failure( .custom(message: "ETC") ))
                    }
                }
                catch  {
                    //MARK:- Parse as error message
                    do {
                        let json = try JSONDecoder().decode( ErrorMessageModel.self, from: data! )
                        print("json msg : ", json.message)
                        print("json code : ", json.code)
                        //MARK:- Failure Cases Handling
                        if json.code == 3003 {
                            completionHandler(.failure( .custom(message: "IPE") ))
                        }
                        else {
                            completionHandler(.failure( .custom(message: "ETCLE") ))
                        }
                    } catch {
                        completionHandler(.failure( .custom(message: "NP") ))
                    }
                }
            case .failure(let error):
                completionHandler(.failure( .custom(message: "NI") ))
            }
        }
    }
    //MARK:- Splash Screen JWT Check
    func callingTokenValidCheckAPI(token: String,  completionHandler : @escaping (Bool) -> ()){
        AF.request(validate_url+token, method: .get, parameters: nil, headers: nil).response{ response in
            switch response.result {
            case .success(let data) :
                if String(data: data!, encoding: .utf8)! == "true"{
                    completionHandler(true)
                }
                else{
                    completionHandler(false)
                }
            case .failure(let error) :
                completionHandler(false)
            }
        }
    }
    
    //MARK:- Send Set Password Again API Call
    func callingResetLoginAPI(id: String,  completionHandler : @escaping (Bool, String) -> ()){
        // Code : "NNC", "UNF" DEAL !! REST - GIVE UP
        AF.request(base_url + "/restorepassword/\(id)", method: .get, parameters: nil, headers: nil).response{ response in
            switch response.result {
            case .success(let data) :
                if response.response?.statusCode == 200 {
                    completionHandler(true, "")
                }
                else{
                    do {
                        let json = try JSONDecoder().decode( ErrorMessageModel.self, from: data! )
                        let code = json.code
                        if code == 3020 {
                            completionHandler(false, "UNF") // UNABLE TO FIND
//                            3020
//                            Unable to find user with the specified login (invalid user identity).
                        }
                        else{
                            completionHandler(false, "UNK")
                        }
                    } catch  {
                        completionHandler(false, "UNK")
                    }
                }
            case .failure(let error) :
                print("Error While Password Reset API Call : \(error.localizedDescription)")
                completionHandler(false, "NNC")
            }
        }
    }
   
    //MARK:- End of VC.
}
