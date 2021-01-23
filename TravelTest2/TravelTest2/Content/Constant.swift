//
//  Constant.swift
//  TravelTest2
//
//  Created by 한석희 on 1/16/21.
//

import Foundation

let app_id = "970A8499-6935-AE1D-FF07-9D8D95AA5500"
let rest_key = "D52ECE6F-F56D-47A8-AAF6-A003669F5480"

let base_url = "https://api.backendless.com/\(app_id)/\(rest_key)/users"
// login,  register -> speciallized url
let register_url = "\(base_url)/register"
let login_url = "\(base_url)/login"
let validate_url = "\(base_url)/isvalidusertoken/"


