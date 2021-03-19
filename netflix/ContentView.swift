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
    @State private var previewNewPos: CGFloat = UIScreen.main.bounds.height
    
    @State private var previewHorizontalDragActive = false
    
    let screen = UIScreen.main.bounds
    
    init() {
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().barTintColor = UIColor.black
    }
    
    var body: some View {
        
        let previewDragGesture = DragGesture(minimumDistance: 20)
            .onChanged { value in
                
                // Checks if the user drags horizontally
                if previewHorizontalDragActive {
                    return
                }
                
                // Checks if the user is somewhere in the middle point,
                // If we drag more horizontally than vertically,
                // set horizontal draggins to true.
                if previewCurrentPos == .zero {
                    if abs(value.translation.width) > abs(value.translation.height) {
                        previewHorizontalDragActive = true
                        return
                    }
                }
                
                // Vertical Dragging
                let shouldBePos = value.translation.height + self.previewNewPos
                
                // In case the user tries to drag up.
                if shouldBePos < 0 {
                    return
                } else {
                    self.previewCurrentPos = shouldBePos
                }
                
                
            }
            .onEnded { value in
                
                // If it was an horizontal drag, turn off, so it doesn't impact the vertical drag.
                if previewHorizontalDragActive {
                    previewHorizontalDragActive = false
                    return
                }
                
                // The snap functionallity
                // Where the user's finger left the view.
                let shouldBePos = value.translation.height + self.previewNewPos
                
                // Dragging up check case and closing point for the view to actually be snapped.
                if shouldBePos < 0 {
                    self.previewCurrentPos = .zero
                    self.previewNewPos = .zero
                } else {
                    let closingPoint = screen.size.height * 0.2
                    
                    if shouldBePos > closingPoint {
                        withAnimation {
                            self.showPreviewFullScreen = false
                            self.previewCurrentPos = screen.height + 32
                            self.previewNewPos = screen.height + 32
                        }
                    } else {
                        withAnimation {
                            self.previewNewPos = .zero
                            self.previewCurrentPos = .zero
                        }
                    }
                }
                
                previewHorizontalDragActive = false
                
            }
        
        return ZStack {
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
                isVisible: $showPreviewFullScreen, externalDragGesture: previewDragGesture)
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
                    previewNewPos = .zero
                }
            } else {
                // hide
                withAnimation {
                    self.previewCurrentPos = screen.height + 32
                    self.previewNewPos = screen.height + 32
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
