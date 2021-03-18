//
//  MoviewPreviewRowView.swift
//  netflix
//
//  Created by Zach Bazov on 17/03/2021.
//

import SwiftUI

struct MoviewPreviewRowView: View {
    
    var movies: [Movie]
    
    @Binding var showPreviewFullScreen: Bool
    @Binding var previewStartingIndex: Int
    
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
                            .frame(width: 128, height: 136)
                            .padding(.trailing, 16)
                            .padding(.leading, 8)
                            .onTapGesture {
                                previewStartingIndex = movieIndex
                                showPreviewFullScreen = true
                            }
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
            MoviewPreviewRowView(movies: exampleMovies, showPreviewFullScreen: .constant(false), previewStartingIndex: .constant(0))
        }
    }
}
