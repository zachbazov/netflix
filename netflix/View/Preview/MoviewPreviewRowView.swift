//
//  MoviewPreviewRowView.swift
//  netflix
//
//  Created by Zach Bazov on 17/03/2021.
//

import SwiftUI

struct MoviewPreviewRowView: View {
    
    var movies: [Movie]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Previews")
                .font(.title3)
                .bold()
                .foregroundColor(.white)
            
            ScrollView(.horizontal, showsIndicators: false, content: {
                LazyHStack {
                    
                    ForEach(0..<movies.count) { movieIndex in
                        let movie = movies[movieIndex]
                        
                        MoviePreviewCell(movie: movie)
                            .frame(width: 128, height: 128)
                            .padding(.trailing, 16)
                            .padding(.leading, 8)
                    }
                    
                }
            })
        }
        .padding(.leading, 8)
    }
}

struct MoviewPreviewRowView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            MoviewPreviewRowView(movies: exampleMovies)
        }
    }
}
