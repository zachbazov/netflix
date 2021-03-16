//
//  MovieDetailView.swift
//  netflix
//
//  Created by Zach Bazov on 15/03/2021.
//

import SwiftUI

struct MovieDetailView: View {
    
    var movie: Movie
    
    let screen = UIScreen.main.bounds
    
    @State private var showSeasonPicker = false
    @State private var selectedSeason = 1
    
    @Binding var movieDetailToShow: Movie?
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            ZStack {
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            movieDetailToShow = nil
                        }, label: {
                            Image(systemName: "xmark.circle")
                                .font(.system(.largeTitle))
                        })
                    }
                    .padding(.horizontal, 16)
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            StandardHomeMovieView(movie: movie)
                                .frame(width: screen.width / 2.5)
                            MovieDetailSubHeadlineView(movie: movie)
                            if movie.promotionHeadline != nil {
                                Text(movie.promotionHeadline!)
                            }
                            FlatButton(text: "Play", image: "play.fill", backgroundColor: .red) {
                                //
                            }
                            
                            InfoDescView(movie: movie)
                            CastCreatorsView(movie: movie)
                            
                            HStack(spacing: 62) {
                                TabButton(text: "My List", image: "checkmark", offImage: "plus", isOn: true) {
                                    //
                                }
                                TabButton(text: "Rate", image: "hand.thumbsup.fill", offImage: "hand.thumbsup", isOn: true) {
                                    //
                                }
                                TabButton(text: "Share", image: "square.and.arrow.up") {
                                    //
                                }
                                Spacer()
                            }
                            .padding(.leading, 8)
                            .padding(.top, 4)
                            
                            // Picker
                            CustomTabSwitcherView(tabs: [.episodes, .trailers, .more], movie: movie, showSeasonPicker: $showSeasonPicker, selectedSeason: $selectedSeason)
                        }
                        .padding(.horizontal, 16)
                    }
                    Spacer()
                }
                .foregroundColor(.white)
                
                if showSeasonPicker {
                    Group {
                        Color.black.opacity(0.9)
                        
                        VStack(spacing: 48) {
                            Spacer()
                            Spacer()
                            ForEach(0..<(movie.numOfSeasons ?? 0)) { season in
                                Button(action: {
                                    self.selectedSeason = season + 1
                                    self.showSeasonPicker = false
                                }, label: {
                                    Text("Season \(season + 1)")
                                        .foregroundColor(selectedSeason == season + 1 ? .white : .gray)
                                        .font(selectedSeason == season + 1 ? .title : .title2)
                                        .bold()
                                })
                            }
                            Spacer()
                            Button(action: {
                                showSeasonPicker = false
                            }, label: {
                                Image(systemName: "x.circle.fill")
                                    .foregroundColor(.white)
                                    .font(.system(size: 48))
                                    .scaleEffect(x: 1.1)
                            })
                            .padding(.bottom, 48)
                        }
                    }
                    .edgesIgnoringSafeArea(.all)
                }
            }
        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movie: exampleMovie1, movieDetailToShow: .constant(nil))
    }
}

struct MovieDetailSubHeadlineView: View {
    
    var movie: Movie
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "hand.thumbsup.fill")
                .foregroundColor(.white)
            Text(String(movie.year))
            RatingView(rating: movie.rating)
            Text(movie.numOfSeasonsDisplay)
            if movie.isHD {
                HDView()
            }
        }
        .foregroundColor(.gray)
        .padding(.vertical)
    }
}

struct RatingView: View {
    
    var rating: String
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.init(hex: "#636363"))
            Text(rating)
                .foregroundColor(.white)
                .font(.system(size: 14))
                .bold()
        }
        .frame(width: 56, height: 24)
        .cornerRadius(3.0)
    }
}

struct HDView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.init(hex: "#384252"))
            Text("HD")
                .foregroundColor(.init(hex: "#d1d1d1"))
                .font(.system(size: 14))
                .bold()
        }
        .frame(width: 36, height: 24)
        .border(Color.init(hex: "#5c5d5e"), width: 2)
        .cornerRadius(4.0)
    }
}

struct InfoDescView: View {
    var movie: Movie
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text(movie.episodeInfoDisplay)
                    .bold()
                Spacer()
            }
            HStack {
                Text(movie.episodeDescriptionDisplay)
                    .font(.subheadline)
                Spacer()
            }
        }
    }
}

struct CastCreatorsView: View {
    var movie: Movie
    var body: some View {
        VStack(spacing: 4) {
            HStack {
                Text("Cast: \(movie.cast)")
                Spacer()
            }
            HStack {
                Text("Creators: \(movie.creators)")
                Spacer()
            }
        }
        .font(.caption)
        .foregroundColor(.init(hex: "#c2c2c2"))
        .padding(.vertical, 6)
    }
}
