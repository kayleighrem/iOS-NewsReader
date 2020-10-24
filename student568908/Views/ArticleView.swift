//
//  ArticleView.swift
//  student568908
//
//  Created by user180971 on 10/22/20.
//

import SwiftUI

struct ArticleView: View {
    @State var article: Articles
    @ObservedObject var newsReaderAPI = NewsReaderAPI.shared
    @State var isliked = false
    
    var body: some View {
        ScrollView {
            VStack {
                if isliked {
                    Button(action:
                        {
                            self.isliked.toggle()
                            NewsReaderAPI.shared.unlikeArticle(withId: article.id) { (result) in
                            switch result {
                            case .success(let response):
                               print(response)
                            case .failure(let error):
                                switch error {
                                case .urlError(let urlError):
                                    print("urlerror: ", urlError)
                                case let decodingError as DecodingError:
                                    print("decodingerror: ", decodingError)
                                    newsReaderAPI.favorites.removeAll(where: {$0.id == article.id})
                                    self.article.isLiked.toggle()
                                case .genericError(let error):
                                    print("error: ", error)
                                default:
                                    print("default")
                                }
                            }
                        }}, label: {
                            Image(systemName: "star.fill").foregroundColor(.yellow)
                        })
                } else {
                    Button(action:
                        {
                            self.isliked.toggle()
                        NewsReaderAPI.shared.likeArticle(withId: article.id) { (result) in
                        switch result {
                        case .success(let response):
                           print(response)
                        case .failure(let error):
                            switch error {
                            case .urlError(let urlError):
                                print("urlerror: ", urlError)
                            case let decodingError as DecodingError:
                                print("decodingerror: ", decodingError)
                                newsReaderAPI.favorites.append(article)
                                self.article.isLiked.toggle()
                            case .genericError(let error):
                                print("error: ", error)
                            default:
                                print("default")
                            }
                        }
                    }}, label: {
                            Image(systemName: "star").foregroundColor(.gray)
                    })
                }
                Text(article.title)
                    .font(.system(.largeTitle, design: .rounded))
                RemoteImage(url: article.image)
                Text(article.summary)
                Link("Button", destination: article.url)
                
            }
            .padding()
        }
        .onAppear {
            isliked = article.isLiked
        }
        .navigationBarTitle("News details", displayMode: .inline)
    }
}
