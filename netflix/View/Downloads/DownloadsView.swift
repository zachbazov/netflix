//
//  DownloadsView.swift
//  netflix
//
//  Created by Zach Bazov on 17/03/2021.
//

import SwiftUI

struct DownloadsView: View {
    
    let screen = UIScreen.main.bounds
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Image(systemName: "info.circle")
                    Text("Smart Downloads")
                    Text("ON")
                        .foregroundColor(.blue)
                    
                    Spacer()
                }
                .padding()
                .font(.system(size: 18, weight: .bold))
                
                ZStack {
                    Circle()
                        .foregroundColor(.graySearchBg)
                    
                    Image(systemName: "arrow.down.to.line.alt")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 75)
                        .foregroundColor(.gray)
                }
                .frame(height: screen.height / 5)
                .padding(.top, screen.height / 7)
                
                VStack(spacing: 24) {
                    Text("Never be without Netflix")
                        .font(.title3)
                        .bold()
                    Text("Download shows and movies so you'll\nnever be without something to watch --\n even when you're offline.")
                        .multilineTextAlignment(.center)
                    Button(action: {
                        
                    }, label: {
                        Text("See what you can download")
                            .foregroundColor(.black)
                            .padding()
                            .background(Color.white)
                    })
                }
                .padding(.top, 32)
                
                Spacer()
            }
            .foregroundColor(.white)
        }
    }
}

struct DownloadsView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            DownloadsView()
        }
    }
}
