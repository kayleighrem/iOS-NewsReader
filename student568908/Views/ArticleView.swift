//
//  ArticleView.swift
//  student568908
//
//  Created by user180971 on 10/22/20.
//

import SwiftUI

struct ArticleView: View {
//    let article: Articles
    
    var body: some View {
        Text("article.title")
//        Text(article.title)
            .navigationTitle("News")
    }
}

struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleView()
//        ArticleView(article: Articles)
    }
}
