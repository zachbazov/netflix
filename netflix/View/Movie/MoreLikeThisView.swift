//
//  MoreLikeThis.swift
//  netflix
//
//  Created by Zach Bazov on 16/03/2021.
//

import SwiftUI

struct MoreLikeThisView: View {
    
    var movies: [Movie]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(0..<movies.count) { index in
                StandardHomeMovieView(movie: movies[index])
            }
        }
        .foregroundColor(.white)
    }
}

struct MoreLikeThis_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            MoreLikeThisView(movies: exampleMovies)
        }
    }
}
