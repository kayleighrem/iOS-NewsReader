//
//  LoginResponse.swift
//  student568908
//
//  Created by user180971 on 10/12/20.
//

import Foundation

struct LoginResponse: Decodable {
    let accessToken: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "AuthToken"
        
    }
}
