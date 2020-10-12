//
//  LoginRequest.swift
//  student568908
//
//  Created by user180971 on 10/11/20.
//

import Foundation


struct LoginRequest: Encodable {
    let username: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case username = "UserName"
        case password = "Password"
    }
}
