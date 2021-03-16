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
                        ForEach(homeVM.getMovie(for: category, andHomeTopNavBar: topNavBarSelection)) { movie in
                            StandardHomeMovieView(movie: movie)
                                .frame(width: 100, height: 200)
                                .padding(.horizontal, 20)
                                .onTapGesture {
                                    movieDetailToShow = movie
                                }
                        }
                    }
                }
            }
        }
    }
}

struct HomeMoviesStack_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                HomeMoviesStack(homeVM: HomeVM(), topNavBarSelection: .home, movieDetailToShow: .constant(nil))
            }
            .foregroundColor(.white)
        }
    }
}
