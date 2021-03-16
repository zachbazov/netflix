//
//  HomeVM.swift
//  netflix
//
//  Created by Zach Bazov on 15/03/2021.
//

import Foundation

class HomeVM: ObservableObject {
    
    @Published var movies: [String: [Movie]] = [:]
    
    public var allCategories: [String] {
        movies.keys.map({ String($0) })
    }
    
    public var allGenres: [HomeGenre] = [.AllGenres, .Action, .Comedy, .Horror, .Thriller]
    
    public func getMovie(for category: String, andHomeTopNavBar homeTopNavBar: HomeTopNavBar, andGenre genre: HomeGenre) -> [Movie] {
        
        switch homeTopNavBar {
        case .home:
            return movies[category] ?? []
        case .tvShows:
            return (movies[category] ?? []).filter({ ($0.movieType == .tvShow) && ($0.genre == genre) })
        case .movies:
            return (movies[category] ?? []).filter({ ($0.movieType == .movie) && ($0.genre == genre) })
        case .myList:
            return movies[category] ?? []
        }
    }
    
    init() {
        setupMovies()
    }
    
    func setupMovies() {
        movies["Trending Now"] = exampleMovies
        movies["Stand-Up Comedy"] = exampleMovies.shuffled()
        movies["New Releases"] = exampleMovies.shuffled()
        movies["Watch It Again"] = exampleMovies.shuffled()
        movies["Sci-Fi"] = exampleMovies.shuffled()
    }
}
