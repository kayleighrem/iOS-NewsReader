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
    let localStorage = LocalStorage()
    @State var articles: [Articles] = []
    
    var body: some View {
        VStack {
            if newsReaderAPI.isAuthenticated {
                List(articles) { article in
                    Text(article.summary)
                        .padding()
                }
//                .onAppear {
//                    newsReaderAPI.getArticles { (result) in
//                        switch result {
//                        case .success(let articles):
//                            self.articles = articles
//                        case .failure(let error):
//                            switch error {
//                            case .urlError(let urlError):
//                                print(urlError)
//                            case .decodingError(let decodingError):
//                                print(decodingError)
//                            case .genericError(let error):
//                                print(error)
//                            }
//                        }
//                    }
//                }
//                Text("Hello you!")
                    .navigationBarItems(leading: Button(action: {
                        newsReaderAPI.logout()
                    }, label: {
                        Image(systemName: "escape")
                    }),
                    trailing: NavigationLink(
                        destination: FavoritesView(),
                        label: {
                            Image(systemName: "star")
                        }
                    )
                )
            } else {
                Text("We need to log in")
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
        }.navigationTitle("News Reader")
    }
}

struct LocalStorage {
    let keychain: Keychain = Keychain()
    let usernameKeychainKey: String = "username"
    
    func fetchUsername() -> String {
        let storedUsername = try?
            keychain.get(usernameKeychainKey)
        return storedUsername ?? ""
    }
    
    func storeUsername(_ username: String) {
        guard username.isEmpty == false else {
            try? keychain.remove(usernameKeychainKey)
            return
        }
        try? keychain.set(username, key: usernameKeychainKey)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
