//
//  SearchView.swift
//  netflix
//
//  Created by Zach Bazov on 17/03/2021.
//

import SwiftUI

struct SearchView: View {
    
    // Once conforms to ObservedObject, may use $var.
    @ObservedObject var vm = SearchVM()
    
    @State private var searchText = ""
    
    @State private var movieDetailToShow: Movie? = nil
    
    var body: some View {
        
        let searchTextBinding = Binding {
            return searchText
        } set: {
            searchText = $0
            vm.updateSearchText(with: $0)
        }
        
        return ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                SearchBarView(text: searchTextBinding, isLoading: $vm.isLoading)
                
                ScrollView {
                    if vm.isShowingPopularMovies {
                        PopularMoviesListView(movies: vm.popularMovies, movieDetailToShow: $movieDetailToShow)
                    }
                    
                    if vm.viewState == .empty {
                        Text("No results found.")
                            .bold()
                            .padding(.top, 150)
                    } else if vm.viewState == .ready && !vm.isShowingPopularMovies {
                        VStack {
                            HStack {
                                Text("Movies & TV")
                                    .bold()
                                    .font(.title3)
                                    .padding(.leading, 10)
                                Spacer()
                            }
                            
                            SearchResultsGridView(movies: vm.searchResults, movieDetailToShow: $movieDetailToShow)
                        }
                    }
                }
                
                Spacer()
            }
            
            if movieDetailToShow != nil {
                MovieDetailView(movie: movieDetailToShow!, movieDetailToShow: $movieDetailToShow)
            }
        }
        .foregroundColor(.white)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

struct PopularMoviesListView: View {
    
    var movies: [Movie]
    
    @Binding var movieDetailToShow: Movie?
    
    var body: some View {
        VStack {
            HStack {
                Text("Popular Searches")
                    .font(.title3)
                    .bold()
                    .padding(.leading, 10)
                    .padding(.top, 4)
                Spacer()
            }
            
            LazyVStack {
                ForEach(movies, id: \.id) { movie in
                    PopularMovieView(movie: movie, movieDetailToShow: $movieDetailToShow)
                        .frame(height: 75)
                }
            }
        }
    }
}
