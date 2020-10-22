//
//  Category.swift
//  student568908
//
//  Created by user180971 on 10/22/20.
//

import Foundation

struct Category: Codable { 
    var id: Int
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
    }
}
