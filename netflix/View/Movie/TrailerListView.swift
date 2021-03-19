//
//  TrailerListView.swift
//  netflix
//
//  Created by Zach Bazov on 16/03/2021.
//

import SwiftUI

struct TrailerListView: View {
    
    var trailers: [Trailer]
    
    let screen = UIScreen.main.bounds
    
    var body: some View {
        VStack {
            ForEach(trailers) { trailer in
                VStack(alignment: .leading) {
                    VideoPreviewImageView(imageURL: trailer.thumbnailImageURL, videoURL: trailer.videoURL)
                        .frame(maxWidth: screen.width)
                    Text(trailer.name)
                        .font(.headline)
                }
                .foregroundColor(.white)
                .padding(.bottom, 8)
            }
        }
    }
}

struct TrailerListView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            TrailerListView(trailers: exampleTrailers)
        }
    }
}
