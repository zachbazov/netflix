//
//  PopularMovieView.swift
//  netflix
//
//  Created by Zach Bazov on 17/03/2021.
//

import SwiftUI
import KingfisherSwiftUI

struct PopularMovieView: View {
    
    var movie: Movie
    
    @Binding var movieDetailToShow: Movie?
    
    //let screen = UIScreen.main.bounds
    
    var body: some View {
        GeometryReader { proxy in
            HStack {
                KFImage(movie.thumbnailURL)
                    .resizable()
                    .frame(width: proxy.size.width / 3)
                    .padding(.leading, 4)
                
                Text(movie.name)
                    .padding(.leading, 8)
                
                Spacer()
                
                Button(action: {
                    
                }, label: {
                    Image(systemName: "arrowtriangle.right.fill")
                })
                .padding(.trailing, 32)
            }
            .foregroundColor(.white)
            .onTapGesture {
                self.movieDetailToShow = movie
            }
        }
    }
}

struct PopularMovieView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            PopularMovieView(movie: exampleMovie1, movieDetailToShow: .constant(nil))
                .frame(height: 75)
        }
    }
}
