//
//  Articles.swift
//  student568908
//
//  Created by user180971 on 10/13/20.
//

import Foundation
import Combine

struct Articles: Codable, Identifiable {
    
    func formatdate(withFormat format: String = "yyyy-dd-MM'T'HH:mm:ss") -> Date? {
        let dateformatter = DateFormatter()
//        dateformatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateformatter.dateFormat = format
        let date = dateformatter.date(from: self.publishDate)
        return date
//        return dateformatter.date(from: "dd-MM-yyyy")
    }
    
    var id: Int
    var feed : Int
    var title : String
    var summary : String
    var url : URL
    var publishDate : String
    var image : String
    var isLiked : Bool
    var related : [URL]
    var categories : [Category]
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
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

struct ArticleLikeResponse: Codable {
    let id: Int
    let isLiked: Bool
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case isLiked = "IsLiked"
    }
}

struct ArticleLikeResponse2: Codable {
    let article: Articles
    
    enum CodingKeys: String, CodingKey {
        case article = "Result"
    }
}

struct ArticleLikeRequest: Codable {
    let id: Int
    let isliked: Bool
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case isliked = "IsLiked"
    }
}
