//
//  ArticleView.swift
//  student568908
//
//  Created by user180971 on 10/22/20.
//

import SwiftUI

struct ArticleView: View {
    var article: Articles
    @State var articles: [Articles] = []

    
    var body: some View {
        ScrollView {
            VStack {
                Text(article.title)
                    .font(.system(.largeTitle, design: .rounded))
                RemoteImage(url: article.image)
                Text(article.summary)
                
            }
            .padding()
        }
        .navigationBarTitle("News details", displayMode: .inline)
        .navigationBarItems(trailing:
            Button(
                action: {
                    print("like article = \(article.isLiked), article id = \(article.id), article = \(article)")
                    NewsReaderAPI.shared.likeArticle(withId: article.id, isliked: true) { (result) in
                        switch result {
                        case .success(let response):
                           print(response)
                        case .failure(_):
                            print("failed")
                            break
                        }
                        print("result = ", result)
                    }
                    print("article liked? = \(article.isLiked)" )
                }
            ) {
                if self.article.isLiked {
                    Image(systemName: "star.fill").foregroundColor(.yellow)
                } else {
                    Image(systemName: "star").foregroundColor(.gray)
                }
            }
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
