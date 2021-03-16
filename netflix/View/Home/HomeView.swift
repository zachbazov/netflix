//
//  HomeView.swift
//  netflix
//
//  Created by Zach Bazov on 15/03/2021.
//

import SwiftUI

struct HomeView: View {
    
    var homeVM = HomeVM()
    
    let screen = UIScreen.main.bounds
    
    @State private var movieDetailToShow: Movie? = nil
    
    @State private var topNavBarSelection: HomeTopNavBar = .home
    @State private var homeGenre: HomeGenre = .AllGenres
    
    @State private var showGenreSelection = false
    @State private var showTopNavBarSelection = false
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            // Main
            // id - Differentiate between categories, by unique param, id.
            ScrollView(showsIndicators: false) {
                // Lazy - Reusing cells for table views.
                // Load the content as soon as the user gets to it.
                LazyVStack {
                    
                    TopNavBar(topNavBarSelection: $topNavBarSelection, homeGenre: $homeGenre, showGenreSelection: $showGenreSelection, showTopNavBarSelection: $showTopNavBarSelection)
                    
                    PromotedMovieView(movie: exampleMovie2)
                        .frame(width: screen.width)
                        .padding(.top, -112)
                        .zIndex(-1)
                    
                    HomeMoviesStack(homeVM: homeVM, topNavBarSelection: topNavBarSelection, selectedGenre: homeGenre, movieDetailToShow: $movieDetailToShow)
                }
            }
            
            // Movie Detail View
            // Not ideal check, doesn't check nil state, may crash.
            if movieDetailToShow != nil {
                MovieDetailView(movie: movieDetailToShow!, movieDetailToShow: $movieDetailToShow)
                    .animation(.easeIn)
                    .transition(.opacity)
            }
            
            // TopNavBar
            if showTopNavBarSelection {
                Group {
                    Color.black.opacity(0.9)
                    
                    VStack(spacing: 48) {
                        
                        Spacer()
                        Spacer()
                        
                        ForEach(HomeTopNavBar.allCases, id: \.self) { topNavBar in
                            
                            Button(action: {
                                topNavBarSelection = topNavBar
                                showTopNavBarSelection = false
                            }, label: {
                                if topNavBar == topNavBarSelection {
                                    Text("\(topNavBar.rawValue)")
                                        .bold()
                                } else {
                                    Text("\(topNavBar.rawValue)")
                                        .foregroundColor(.gray)
                                }
                            })
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            showTopNavBarSelection = false
                        }, label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: 48))
                                .scaleEffect(x: 1.1)
                        })
                        .padding(.bottom, 48)
                    }
                }
                .edgesIgnoringSafeArea(.all)
                .font(.title2)
            }
            
            // Genre
            if showGenreSelection {
                Group {
                    Color.black.opacity(0.9)
                    
                    VStack(spacing: 48) {
                        
                        Spacer()
                        Spacer()
                        
                        ScrollView {
                            ForEach(homeVM.allGenres, id: \.self) { genre in
                                
                                Button(action: {
                                    homeGenre = genre
                                    showGenreSelection = false
                                }, label: {
                                    if genre == homeGenre {
                                        Text("\(genre.rawValue)")
                                            .bold()
                                    } else {
                                        Text("\(genre.rawValue)")
                                            .foregroundColor(.gray)
                                    }
                                })
                                .padding(.bottom, 40)
                            }
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            showGenreSelection = false
                        }, label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: 48))
                                .scaleEffect(x: 1.1)
                        })
                        .padding(.bottom, 48)
                    }
                }
                .edgesIgnoringSafeArea(.all)
                .font(.title2)
            }
        }
        .foregroundColor(.white)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct TopNavBar: View {
    
    @Binding var topNavBarSelection: HomeTopNavBar
    @Binding var homeGenre: HomeGenre
    
    @Binding var showGenreSelection: Bool
    @Binding var showTopNavBarSelection: Bool
    
    var body: some View {
        switch topNavBarSelection {
        case .home:
            HStack(spacing: 16) {
                Button(action: {
                    topNavBarSelection = .home
                }, label: {
                    Image("netflix_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 48)
                })
                .padding(.leading, 24)
                HStack(spacing: 32) {
                    Button(action: {
                        topNavBarSelection = .tvShows
                    }, label: {
                        Text("TV Shows")
                            .font(.system(size: 20))
                    })
                    Button(action: {
                        topNavBarSelection = .movies
                    }, label: {
                        Text("Movies")
                            .font(.system(size: 14))
                    })
                    Button(action: {
                        topNavBarSelection = .myList
                    }, label: {
                        Text("My List")
                            .font(.system(size: 14))
                    })
                    Spacer()
                }
            }
        case .tvShows, .movies, .myList:
            HStack(spacing: 16) {
                Button(action: {
                    topNavBarSelection = .home
                }, label: {
                    Image("netflix_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 48)
                })
                .padding(.leading, 24)
                HStack(spacing: 32) {
                    Button(action: {
                        showTopNavBarSelection = true
                        //topNavBarSelection = .tvShows
                    }, label: {
                        HStack {
                            Text(topNavBarSelection.rawValue)
                                .font(.system(size: 20))
                            Image(systemName: "triangle.fill")
                                .rotationEffect(.degrees(180), anchor: .center)
                                .scaleEffect(x: 1.6)
                                .font(.system(size: 6))
                                .padding(.top, 3)
                                .padding(.leading, 2)
                        }
                    })
                    Button(action: {
                        showGenreSelection = true
                        //topNavBarSelection = .movies
                    }, label: {
                        HStack {
                            Text(homeGenre.rawValue)
                                .font(.system(size: 14))
                            Image(systemName: "triangle.fill")
                                .rotationEffect(.degrees(180), anchor: .center)
                                .scaleEffect(x: 1.6)
                                .font(.system(size: 6))
                                .padding(.top, 3)
                                .padding(.leading, 2)
                        }
                    })
                    Spacer()
                }
            }
        }
    }
}

enum HomeTopNavBar: String, CaseIterable {
    case home = "Home"
    case tvShows = "TV Shows"
    case movies = "Movies"
    case myList = "My List"
}

enum HomeGenre: String {
    case AllGenres = "All Genres"
    case Action
    case Comedy
    case Horror
    case Thriller
}
