//
//  Articles.swift
//  student568908
//
//  Created by user180971 on 10/13/20.
//

import Foundation
import Combine

struct Articles: Codable, Identifiable {
    var id = UUID()
    var feed : Int
    var title : String
    var summary : String
    var url : URL
    var publishDate : String
    var image : String
    var isLiked : Bool
    var related : [String]
    var categories : [Category]
    
    enum CodingKeys: String, CodingKey {
//        case id = "Id"
        case feed = "Feed"
        case title = "Title"
        case summary = "Summary"
        case url = "Url"
        case publishDate = "PublishDate"
        case image = "Image"
        case isLiked = "IsLiked"
        case related = "Related"
        case categories = "Categories"
    }
}

struct ArticleResponse: Decodable {
    let articles: [Articles]
    
    enum CodingKeys: String, CodingKey {
        case articles = "Results"
    }
}

//struct ArticleRequest: Encodable {
//    let article: Articles
//    let nextid: Int
//    
//    enum CodingKeys: String, CodingKey {
//        case article = "Results"
//        case nextid = "NextId"
//    }
//}
