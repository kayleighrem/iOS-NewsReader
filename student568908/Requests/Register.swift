//
//  RegisterRequest.swift
//  student568908
//
//  Created by user180971 on 10/12/20.
//

import Foundation

struct RegisterRequest: Encodable {
    let username: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case username = "UserName"
        case password = "Password"
    }
}

struct RegisterResponse: Decodable {
    let success: Bool
    
    enum CodingKeys: String, CodingKey {
        case success = "Success"
    }
}
