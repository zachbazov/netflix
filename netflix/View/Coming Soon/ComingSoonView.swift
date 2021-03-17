//
//  ComingSoonView.swift
//  netflix
//
//  Created by Zach Bazov on 17/03/2021.
//

import SwiftUI

struct ComingSoonView: View {
    
    @State private var showNoficiationList = false
    
    @State private var navBarHidden = true
    
    @State private var movieDetailToShow: Movie? = nil
    
    @State private var scrollOffset: CGFloat = 0.0
    
    @State private var activeIndex = 0
    
    @ObservedObject var vm = ComingSoonVM()
    
    func updateActiveIndex(fromScroll scroll: CGFloat) {
        if scroll < 105 {
            activeIndex = 0
        } else {
            let remove105 = scroll - 105
            let active = Int(remove105 / 410) + 1
            activeIndex = Int(active)
        }
    }
    
    var body: some View {
        
        let movies = vm.movies.enumerated().map({ $0 })
        
        let scrollTrackingBinding = Binding {
            return scrollOffset
        } set: { newVal in
            scrollOffset = newVal
            updateActiveIndex(fromScroll: newVal)
        }
        
        
        return Group {
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                
                TrackableScrollView(.vertical, showIndicators: false, contentOffset: scrollTrackingBinding) {
                    
                    LazyVStack {
                        NotificationBarView(showNotificationList: $showNoficiationList)
                        
                        // generic parameter, offset coming from the index of emunarated array.
                        ForEach(Array(movies), id: \.offset) { index, movie in
                            ComingSoonItemView(movie: movie, movieDetailToShow: $movieDetailToShow)
                                .frame(height: 400)
                                .overlay(
                                    Group {
                                        index == activeIndex ? Color.clear : Color.black.opacity(0.8)
                                    }
                                    .animation(.easeInOut)
                                )
                        }
                    }
                }
                .foregroundColor(.white)
                
                NavigationLink(
                    destination: Text("Notifications List"),
                    isActive: $showNoficiationList,
                    label: { EmptyView() })
                    .navigationTitle("")
                    .foregroundColor(.white)
                    .navigationBarHidden(navBarHidden)
                    .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification), perform: { _ in
                        self.navBarHidden = true
                    })
                    .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification), perform: { _ in
                        self.navBarHidden = false
                    })
            }
            
            //                VStack {
            //                    Text("\(scrollOffset)")
            //                        .background(Color.red)
            //                        .font(.title)
            //                    Text("\(activeIndex)")
            //                        .background(Color.blue)
            //                        .font(.title)
            //                }
            
        }
    }
}

struct ComingSoonView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            ComingSoonView()
        }
    }
}
