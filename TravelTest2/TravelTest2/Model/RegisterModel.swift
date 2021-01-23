//
//  RegisterModel.swift
//  TravelTest2
//
//  Created by 한석희 on 1/16/21.
//

import Foundation

struct RegisterModel : Encodable {
    
    let id : String // not null, unique
    let password : String // not null
    let email : String
    
}
