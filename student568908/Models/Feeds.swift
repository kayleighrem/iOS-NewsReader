//
//  Feeds.swift
//  student568908
//
//  Created by user180971 on 10/13/20.
//

import Foundation

struct Feeds : Identifiable {
    var id = UUID()
    var name: String
}

struct FeedResponse: Decodable {
    let accessToken: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "AuthToken"
    }
}

struct FeedRequest: Encodable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
    }
}
