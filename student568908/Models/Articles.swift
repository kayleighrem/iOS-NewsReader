//
//  Articles.swift
//  student568908
//
//  Created by user180971 on 10/13/20.
//

import Foundation
import Combine

<<<<<<< Updated upstream
//struct Article: Codable, Identifiable {
struct Articles: Decodable, Identifiable {
=======
struct Articles: Codable, Identifiable {
>>>>>>> Stashed changes
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

struct GetArticleResponse: Decodable {
    let articles: [Articles]
    
    enum CodingKeys: String, CodingKey {
        case articles = "Results"
    }
}

<<<<<<< Updated upstream
//struct ArticleRequest: Decodable {
//    let feed: String
//    let title: String
//    let summary : String
//    let url : URL
//    let publishDate : String
//    let image : String
//    let isLiked : Bool
//    let related : [String]
//    let categories : [String]
//    
//    enum CodingKeys: String, CodingKey {
//        case feed = "Feed"
//        case title = "Title"
//        case summary = "Summary"
//        case publishDate = " PublishDate"
//        case image = "Image"
//        case url = "Url"
//        case relates = "Related"
//        case categories = "Categories"
//        case isLiked = "IsLiked"
//    }
//}
=======
>>>>>>> Stashed changes
