//
//  ContentView.swift
//  student568908
//
//  Created by user180971 on 10/11/20.
//

import SwiftUI
import KeychainAccess

struct ContentView: View {
    @ObservedObject var newsReaderAPI = NewsReaderAPI.shared
    @State var articles: [Articles] = []
    
    var body: some View {
        NavigationView {
            VStack {
                List(articles) { article in
                    NavigationLink(destination: ArticleView(article: article)) {
                        RemoteImage(url: article.image)
                            .frame(width: 54, height: 54)
                            .cornerRadius(20)
                        VStack(alignment: .leading) {
                            HStack {
                                Text(article.title)
                                    .font(.subheadline)
                                if article.isLiked == false {
                                    Image(systemName: "star.fill").foregroundColor(.yellow)
                                }
                            }
                        }
                    }
                }
                .onAppear {
                    newsReaderAPI.getArticles { (result) in
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
                if newsReaderAPI.isAuthenticated {
                    Text("")
                        .navigationBarItems(leading: Button(action: {
                            newsReaderAPI.logout()
                        }, label: {
                            Image(systemName: "escape")
                        }),
                        trailing: NavigationLink(
                            destination: FavoritesView(),
//                            action: newsReaderAPI.getLiked(),
                            label: {
                                Image(systemName: "star")
                            })
                        )} else {
                            Text("Not logged in")
                                .navigationBarItems(leading: NavigationLink( destination: LoginView(),
                                    label: {
                                        Text("Log in")
                                    }
                                ),
                                trailing: NavigationLink(
                                    destination: RegisterView(),
                                    label: {
                                        Text("Register")
                                    })
                                )
                        }
            }.navigationTitle("News")
        }.navigationBarHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
