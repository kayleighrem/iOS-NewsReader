//
//  FavoritesView.swift
//  student568908
//
//  Created by user180971 on 10/13/20.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var newsReaderAPI = NewsReaderAPI.shared
    @State var articles: [Articles] = []
    
    var body: some View {
        VStack {
            List(articles) { article in
                if article.isLiked {
                    NavigationLink(destination: ArticleView(article: article)) {
                        RemoteImage(url: article.image)
                            .frame(width: 54, height: 54)
                            .cornerRadius(20)
                        VStack(alignment: .leading) {
                            Text(article.title)
                        }
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                    }
                } else {
                    Text("No favorites")
                }
            }
            .onAppear {
                newsReaderAPI.getLiked { (result) in
                    switch result {
                    case .success(let articles):
                        self.articles = articles
                    case .failure(let error):
                        switch error {
                        case .urlError(let urlError):
                            print(urlError)
                        case .decodingError(let decodingError):
                            print(decodingError)
                        case .genericError(let error):
                            print(error)
                        }
                    }
                }
            }
            
        }.navigationTitle("Favorites")
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
