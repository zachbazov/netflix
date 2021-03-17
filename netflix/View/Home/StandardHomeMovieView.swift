//
//  StandardHomeMovie.swift
//  netflix
//
//  Created by Zach Bazov on 15/03/2021.
//

import SwiftUI
import KingfisherSwiftUI

struct StandardHomeMovieView: View {
    
    var movie: Movie
    
    var body: some View {
        GeometryReader { proxy in
            KFImage(movie.thumbnailURL)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: proxy.size.width, height: proxy.size.height)
                .clipped()
        }
    }
}

struct StandardHomeMovieView_Previews: PreviewProvider {
    static var previews: some View {
        StandardHomeMovieView(movie: exampleMovie1)
            //.frame(width: 100, height: 400)
    }
}
