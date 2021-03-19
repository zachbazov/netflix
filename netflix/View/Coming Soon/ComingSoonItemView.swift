//
//  ComingSoonItemView.swift
//  netflix
//
//  Created by Zach Bazov on 17/03/2021.
//

import SwiftUI
import KingfisherSwiftUI
import AVKit

struct ComingSoonItemView: View {
    
    var movie: Movie
    
    @Binding var movieDetailToShow: Movie?
    
    let screen = UIScreen.main.bounds
    
    var player: AVPlayer {
        AVPlayer(url: URL(string: "https://radiantmediaplayer.com/media/big-buck-bunny-360p.mp4")!)
    }
    
    var body: some View {
        VStack {
            VideoPlayer(player: player)
                .frame(height: 200)
            
            VStack {
                HStack {
                    KFImage(movie.thumbnailURL)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: screen.width / 3, height: 75)
                        .clipped()
                    
                    Spacer()
                    
                    
                    Button(action: {
                        //
                    }, label: {
                        VStack(spacing: 4) {
                            Image(systemName: "bell")
                                .font(.title2)
                            Text("Remind Me")
                        }
                    })
                    .padding(.horizontal)
                    
                    Button(action: {
                        movieDetailToShow = movie
                    }, label: {
                        VStack(spacing: 4) {
                            Image(systemName: "info.circle")
                                .font(.title2)
                            Text("Info")
                        }
                    })
                    .padding(.trailing, 24)
                    
                }
                .font(.caption)
                
                VStack(alignment: .leading) {
                    Text(movie.name)
                        .font(.title2)
                        .bold()
                        .padding(.top, 4)
                    Text(movie.episodeDescriptionDisplay)
                        .foregroundColor(.gray)
                        .padding(.trailing)
                        .padding(.top, 1)
                }
            }
            .foregroundColor(.white)
            .padding(.leading)
        }
    }
}

struct ComingSoonItemView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            ComingSoonItemView(movie: exampleMovie1, movieDetailToShow: .constant(nil))
        }
    }
}
