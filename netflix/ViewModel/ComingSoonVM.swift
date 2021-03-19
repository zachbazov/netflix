//
//  ComingSoonVM.swift
//  netflix
//
//  Created by Zach Bazov on 17/03/2021.
//

import Foundation

class ComingSoonVM: ObservableObject {
    
    @Published var movies: [Movie] = []
    
    init() {
        self.movies = generateMovies(20)
    }
}
