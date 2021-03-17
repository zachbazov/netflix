//
//  SearchVM.swift
//  netflix
//
//  Created by Zach Bazov on 17/03/2021.
//

import Foundation
import SwiftUI

class SearchVM: ObservableObject {
    
    // For ObservableObject use @Published
    @Published var isLoading = false
    
    @Published var viewState: ViewState = ViewState.ready
    
    @Published var popularMovies: [Movie] = []
    @Published var searchResults: [Movie] = []
    
    @Published var isShowingPopularMovies = true
    
    init() {
        getPopularMovies()
    }
    
    public func updateSearchText(with text: String) {
        // set loading state
        setViewState(to: .loading)
        
        // get results
        if text.count > 0 {
            isShowingPopularMovies = false
            getSearchResults(forText: text)
        } else {
            isShowingPopularMovies = true
        }
    }
    
    private func getPopularMovies() {
        self.popularMovies = generateMovies(40)
    }
    
    private func getSearchResults(forText text: String) {
        
        let haveResult = Int.random(in: 0...3)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if haveResult == 0 {
                self.searchResults = []
                self.setViewState(to: .empty)
            } else {
                let movies = generateMovies(21)
                self.searchResults = movies
                self.setViewState(to: .ready)
            }
        }
    }
    
    private func setViewState(to state: ViewState) {
        // In the main thread because the UI changes.
        DispatchQueue.main.async {
            self.viewState = state
            
            self.isLoading = state == .loading
        }
    }
}


enum ViewState {
    case empty
    case loading
    case ready
    case error
}
