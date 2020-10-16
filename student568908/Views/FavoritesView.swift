//
//  FavoritesView.swift
//  student568908
//
//  Created by user180971 on 10/13/20.
//

import SwiftUI

struct FavoritesView: View {
    @State var feeds : [Feeds] = []
    
    var body: some View {
//        List(feeds) { feed in
//            Text(feed.name)
//            .padding()
//        }.onAppear {
//            NewsReaderAPI.shared.getFeeds() { (result) in
//                switch result {
//                case .success(let feeds):
//                    self.feeds = feeds
//                case .failure(let error):
//                    switch error {
//                    case .urlError(let urlError):
//                        print(urlError)
//                    case .decodingError(let decodingError):
//                        print(decodingError)
//                    case .genericError(let error):
//                        print(error)
//                    }
//                }
//            }
//        }
        Text("hoi test")
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
