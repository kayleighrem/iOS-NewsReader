//
//  ArticleView.swift
//  student568908
//
//  Created by user180971 on 10/22/20.
//

import SwiftUI

struct ArticleView: View {
    let article: Articles
    
    var body: some View {
        ScrollView {
            VStack {
                Text(article.title)
                    .font(.system(.largeTitle, design: .rounded))
//                Text(article.categories.first)
//                Text(article.formatdate(withFormat: article.publishDate))
                RemoteImage(url: article.image)
                Text(article.summary)
            }
            .padding()

        }
        .navigationBarTitle("News details", displayMode: .inline)
        .navigationBarItems(trailing:
            Button(
                action: { NewsReaderAPI.shared.likeArticle(id: article.id)} , 
                label: {
                    if article.isLiked {
                        Image(systemName: "star.fill")
                    } else {
                        Image(systemName: "star")
                    }
                }
            )
        )
    }
}

func makeFave() {
    
}

//struct ArticleView_Previews: PreviewProvider {
//    static var previews: some View {
//        ArticleView(article: Articles)
//    }
//}
