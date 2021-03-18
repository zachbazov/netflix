//
//  ContentView.swift
//  netflix
//
//  Created by Zach Bazov on 15/03/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showPreviewFullScreen = false
    @State private var previewStartingIndex = 0
    
    @State private var previewCurrentPos: CGFloat = UIScreen.main.bounds.height
    
    let screen = UIScreen.main.bounds
    
    init() {
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().barTintColor = UIColor.black
    }
    
    var body: some View {
        ZStack {
            TabView {
                HomeView(
                    showPreviewFullScreen: $showPreviewFullScreen,
                    previewStartingIndex: $previewStartingIndex)
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }.tag(0)
                
                SearchView()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }.tag(1)
                
                ComingSoonView()
                    .tabItem {
                        Image(systemName: "play.rectangle")
                        Text("Coming Soon")
                    }.tag(2)
                
                DownloadsView()
                    .tabItem {
                        Image(systemName: "arrow.down.to.line.alt")
                        Text("Downloads")
                    }.tag(3)
                
    //            Text("More")
    //                .tabItem {
    //                    Image(systemName: "ellipsis.circle")
    //                        .padding(.top, 8)
    //                    Text("More")
    //                }.tag(4)
            }
            .accentColor(.white)
            
            PreviewListView(
                movies: exampleMovies,
                currentSelection: $previewStartingIndex,
                isVisible: $showPreviewFullScreen)
                .offset(y: previewCurrentPos)
                /// If `showPreviewFullScreen` set to true, then the preview is not hidden.
                /// Set to false, then the preview is hidden.
                .isHidden(!showPreviewFullScreen)
                .animation(.easeIn)
                .transition(.move(edge: .bottom))
        }
        .onChange(of: showPreviewFullScreen, perform: { value in
            if value {
                // show
                withAnimation {
                    previewCurrentPos = .zero
                }
            } else {
                // hide
                withAnimation {
                    previewCurrentPos = screen.height + 32
                }
            }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
