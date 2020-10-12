//
//  ContentView.swift
//  student568908
//
//  Created by user180971 on 10/11/20.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var newsReaderAPI = NewsReaderAPI.shared
    
    var body: some View {
        VStack {
            if newsReaderAPI.isAuthenticated {
                Text("We are logged in")
                    .navigationBarItems(leading: Button(action: {
                        newsReaderAPI.logout()
                    }, label: {
                        Image(systemName: "escape")
                    }),
                    trailing: NavigationLink(
                        destination: Text("Favorite Articles"),
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
