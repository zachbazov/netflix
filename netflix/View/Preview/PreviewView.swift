//
//  PreviewView.swift
//  netflix
//
//  Created by Zach Bazov on 18/03/2021.
//

import SwiftUI

struct PreviewView: View {
    
    @ObservedObject var vm: PreviewVM
    
    var body: some View {
        ZStack {
            
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            TrailerPlayerView(
                videoURL: vm.movie.trailers.first?.videoURL,
                playVideo: .constant(true))
            
            VStack(spacing: 16) {
                HStack {
                    VStack(alignment: .leading, spacing: 0, content: {
                        Text(vm.movie.name)
                            .foregroundColor(vm.movie.accentColor)
                            .bold()
                            .font(.largeTitle)
                    })
                    
                    Spacer()
                    
                }
                .padding(.leading, 16)
                .padding(.top, 64)
                
                Spacer()
                
                HStack {
                    ForEach(0..<vm.movie.categories.count) { i in
                        HStack {
                            
                            let category = vm.movie.categories[i]
                            Text(category)
                                .font(.footnote)
                            
                            if i != vm.movie.categories.count - 1 {
                                Image(systemName: "circle.fill")
                                    .font(.system(size: 3))
                            }
                        }
                    }
                }
                
                HStack {
                    Spacer()
                    
                    TabButton(text: "My List", image: "checkmark", offImage: "plus", isOn: true, color: vm.movie.accentColor ?? Color.white) {
                        //
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        //
                    }, label: {
                        HStack {
                            Image(systemName: "arrowtriangle.right.fill")
                            Text("PLAY")
                                .fontWeight(.heavy)
                        }
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .border(vm.movie.accentColor ?? Color.white, width: 3)
                    })
                    
                    Spacer()
                    
                    TabButton(text: "Info", image: "info.circle", color: vm.movie.accentColor ?? Color.white) {
                        //
                    }
                    
                    Spacer()
                }
                
            }
            .padding(.bottom, 64)
            .foregroundColor(vm.movie.accentColor)
            
        }
        .edgesIgnoringSafeArea(.vertical)
        
    }
}

struct PreviewView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewView(vm: PreviewVM(movie: exampleMovie1))
    }
}
