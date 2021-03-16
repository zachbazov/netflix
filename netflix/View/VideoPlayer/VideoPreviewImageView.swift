//
//  VideoPreviewImageView.swift
//  netflix
//
//  Created by Zach Bazov on 16/03/2021.
//

import SwiftUI
import KingfisherSwiftUI

struct VideoPreviewImageView: View {
    
    var imageURL: URL
    var videoURL: URL
    
    @State private var showingVideoPlayer = false
    
    var body: some View {
        ZStack {
            KFImage(imageURL)
                .resizable()
                .aspectRatio(contentMode: .fill)
            Button(action: {
                showingVideoPlayer = true
            }, label: {
                Image(systemName: "play.circle")
                    .foregroundColor(.white)
                    .background(Color.init(hex: "#000").opacity(0.5))
                    .font(.system(size: 40))
                    .cornerRadius(30.0)
            })
            .sheet(isPresented: $showingVideoPlayer, content: {
                SwiftUIVideoView(url: videoURL)
            })
        }
    }
}

struct VideoPreviewImageView_Previews: PreviewProvider {
    static var previews: some View {
        VideoPreviewImageView(imageURL: exampleImageURL1, videoURL: exampleVideoURL)
    }
}
