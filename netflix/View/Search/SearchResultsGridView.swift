//
//  SearchResultsGridView.swift
//  netflix
//
//  Created by Zach Bazov on 17/03/2021.
//

import SwiftUI

struct SearchResultsGridView: View {
    
    var movies: [Movie]
    
    @Binding var movieDetailToShow: Movie?
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(movies, id: \.id) { movie in
                StandardHomeMovieView(movie: movie)
                    .frame(height: 160)
                    .onTapGesture {
                        movieDetailToShow = movie
                    }
            }
        }
    }
}

struct SearchResultsGridView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            SearchResultsGridView(movies: generateMovies(20), movieDetailToShow: .constant(nil))
        }
    }
}
