//
//  FavoritesView.swift
//  student568908
//
//  Created by user180971 on 10/13/20.
//

import SwiftUI

struct FavoritesView: View {
    @State var feeds: [Feed] = []
    @State var articles: [Articles] = []
    
    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//        List(feeds) { feed in
//            Text(feed.name)
//                .padding()
//        }
        List(articles) { article in
            Text(article.summary)
                .padding()
        }
        .onAppear {
            NewsReaderAPI.shared.getArticles { (result) in
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
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
