//
//  LoginModel.swift
//  TravelTest2
//
//  Created by 한석희 on 1/17/21.
//

import Foundation
import UIKit

struct LoginModel: Encodable {
    let login : String
    let password : String
  }

//MARK:- Login Resonse Model
struct LoginResponseModel: Codable {
    let lastLogin: Int
    let userStatus: String
    let created: Int
    let welcomeClass, blUserLocale, id, userToken: String
    let ownerID, socialAccount: String
//    let updated: JSONNull?
    let objectID: String

    enum CodingKeys: String, CodingKey {
        case lastLogin, userStatus, created
        case welcomeClass = "___class"
        case blUserLocale, id
        case userToken = "user-token"
        case ownerID = "ownerId"
        case socialAccount
        case objectID = "objectId"
    }
}


struct ErrorMessageModel : Codable{
    let message : String
    let code : Int
}
