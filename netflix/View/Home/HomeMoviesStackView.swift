//
//  HomeMoviesStackView.swift
//  netflix
//
//  Created by Zach Bazov on 16/03/2021.
//

import SwiftUI

struct HomeMoviesStack: View {
    
    var homeVM: HomeVM
    
    var topNavBarSelection: HomeTopNavBar
    var selectedGenre: HomeGenre
    
    @Binding var movieDetailToShow: Movie?
    
    var body: some View {
        ForEach(homeVM.allCategories, id: \.self) { category in
            VStack {
                
                HStack {
                    Text(category)
                        .font(.title3)
                        .bold()
                    Spacer()
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(homeVM.getMovie(for: category, andHomeTopNavBar: topNavBarSelection, andGenre: selectedGenre)) { movie in
                            StandardHomeMovieView(movie: movie)
                                .frame(width: 136, height: 160)
                                .onTapGesture {
                                    movieDetailToShow = movie
                                }
                        }
                    }
                }
                
            }
            .padding(.leading, 8)
        }
    }
}

struct HomeMoviesStack_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                HomeMoviesStack(homeVM: HomeVM(), topNavBarSelection: .home, selectedGenre: .AllGenres, movieDetailToShow: .constant(nil))
            }
            .foregroundColor(.white)
        }
    }
}
