//
//  TopMoviePreview.swift
//  netflix
//
//  Created by Zach Bazov on 15/03/2021.
//

import SwiftUI
import KingfisherSwiftUI

struct PromotedMovieView: View {
    
    var movie: Movie
    
    func isCategoryLast(_ category: String) -> Bool {
        let count = movie.categories.count
        if let index = movie.categories.firstIndex(of: category) {
            if index + 1 != count { return false }
        }
        return true
    }
    
    var body: some View {
        ZStack {
            KFImage(movie.thumbnailURL)
                .resizable()
                .scaledToFill()
                .clipped()
            
            VStack {
                Spacer()
                HStack {
                    ForEach(movie.categories, id: \.self) { category in
                        HStack {
                            Text(category)
                                .font(.system(size: 14))
                            if !isCategoryLast(category) {
                                Image(systemName: "circle.fill")
                                    .foregroundColor(.blue)
                                    .font(.system(size: 3))
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
                
                HStack {
                    Spacer()
                    TabButton(text: "My List", image: "checkmark", offImage: "plus", isOn: true) {
                        //
                    }
                    Spacer()
                    FlatButton(text: "Play", image: "play.fill") {
                        // 
                    }
                    .frame(width: 120)
                    Spacer()
                    TabButton(text: "Info", image: "info.circle") {
                        //
                    }
                    Spacer()
                }
            }
            .background(
                LinearGradient.fadingBlackOverlay
                    .padding(.top, UIScreen.main.bounds.height / 2)
            )
        }
        .foregroundColor(.white)
    }
}

struct PromotedMovieView_Previews: PreviewProvider {
    static var previews: some View {
        PromotedMovieView(movie: exampleMovie1)
    }
}
