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
        KFImage(movie.thumbnailURL)
            .resizable()
            .scaledToFill()
    }
}

struct StandardHomeMovieView_Previews: PreviewProvider {
    static var previews: some View {
        StandardHomeMovieView(movie: exampleMovie1)
            //.frame(width: 200, height: 300)
    }
}
