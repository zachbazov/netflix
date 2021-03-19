//
//  PreviewVM.swift
//  netflix
//
//  Created by Zach Bazov on 18/03/2021.
//

import Foundation

class PreviewVM: ObservableObject {
    
    var movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
}
