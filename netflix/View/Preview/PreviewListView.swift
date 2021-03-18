//
//  PreviewListView.swift
//  netflix
//
//  Created by Zach Bazov on 18/03/2021.
//

import SwiftUI

struct PreviewListView: View {
    
    var movies: [Movie]
    
    @Binding var currentSelection: Int
    @Binding var isVisible: Bool
    @State private var currentTranslation: CGFloat = 0.0
    
    let screen = UIScreen.main.bounds
    
    func shouldPlayVideo(index: Int) -> Bool {
        if !isVisible {
            return false
        }
        
        if index != currentSelection {
            return false
        }
        
        return true
    }
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            PagerView(pageCount: movies.count, currentIndex: $currentSelection, translation: $currentTranslation) {
                
                ForEach(0..<movies.count) { i in
                    let movie = movies[i]
                    
                    PreviewView(
                        vm: PreviewVM(movie: movie),
                        playVideo: shouldPlayVideo(index: i)
                    )
                    .frame(width: screen.width)
                }
                
            }
            .frame(width: screen.width)
            
        }
    }
}

struct ExamplePreviewList: View {
    @State private var currentSelection = 0
    @State private var isVisible = true
    var body: some View {
        PreviewListView(movies: exampleMovies, currentSelection: $currentSelection, isVisible: $isVisible)
    }
}

struct PreviewListView_Previews: PreviewProvider {
    static var previews: some View {
        ExamplePreviewList()
    }
}
