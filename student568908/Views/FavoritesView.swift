//
//  FavoritesView.swift
//  student568908
//
//  Created by user180971 on 10/13/20.
//

import SwiftUI

struct FavoritesView: View {
    @State var feeds: [Feed] = []
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        List(feeds) { feed in
            Text(feed.name)
                .padding()
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
