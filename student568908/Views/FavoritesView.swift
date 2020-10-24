//
//  FavoritesView.swift
//  student568908
//
//  Created by user180971 on 10/13/20.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var newsReaderAPI = NewsReaderAPI.shared
//    @State var articles: [Articles] = []
    
    var body: some View {
        VStack {
            // or progressbar
            if newsReaderAPI.favorites.isEmpty {
                Text("no favorites")
            } else {
                List(newsReaderAPI.favorites) { favorite in
                        NavigationLink(destination: ArticleView(article: favorite)) {
                            RemoteImage(url: favorite.image)
                                .frame(width: 54, height: 54)
                                .cornerRadius(20)
                            VStack(alignment: .leading) {
                                Text(favorite.title)
                            }
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                }

            }
        }
        }
            .navigationTitle("Favorites")
            .onAppear {
                newsReaderAPI.getLiked { (result) in
                    switch result {
                    case .success(let favorite):
                        self.newsReaderAPI.favorites = favorite
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

