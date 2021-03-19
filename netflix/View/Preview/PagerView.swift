//
//  PagerView.swift
//  netflix
//
//  Created by Zach Bazov on 17/03/2021.
//

import SwiftUI

struct PagerView<Content: View>: View {
    
    let pageCount: Int
    @Binding var currentIndex: Int
    @Binding var translation: CGFloat
    
    // Drag Gesture
    @State private var verticalDragIsActive = false
    
    // the exact type of DragGesture.
    let externalDragGesture: _EndedGesture<_ChangedGesture<DragGesture>>
    
    let content: Content
    
    init(
        pageCount: Int,
        currentIndex: Binding<Int>,
        translation: Binding<CGFloat>,
        externalDragGesture: _EndedGesture<_ChangedGesture<DragGesture>>,
        @ViewBuilder content: () -> Content
    ) {
        self.pageCount = pageCount
        self._currentIndex = currentIndex
        self._translation = translation
        self.content = content()
        self.externalDragGesture = externalDragGesture
    }
    
    var body: some View {
        GeometryReader { geo in
            HStack(spacing: 0) {
                self.content
                    .frame(width: geo.size.width)
            }
            .frame(width: geo.size.width, alignment: .leading)
            .offset(x: -CGFloat(self.currentIndex) * geo.size.width)
            .offset(x: self.translation)
            .animation(.interactiveSpring())
            .gesture(
                externalDragGesture.simultaneously(
                    with:
                        DragGesture(minimumDistance: 20)
                        .onChanged({ value in
                            
                            if verticalDragIsActive {
                                return
                            }
                            
                            // enable vertical dragging
                            if abs(value.translation.width) < abs(value.translation.height) {
                                verticalDragIsActive = true
                                return
                            }
                            
                            // Horizontal Drag only available now
                            translation = value.translation.width
                        })
                        .onEnded({ value in
                            
                            if verticalDragIsActive {
                                verticalDragIsActive = false
                                return
                            }
                            
                            // Ending horizontal drag
                            // Snaps the view to the edge.
                            let offset = value.translation.width / geo.size.width
                            let newIndex = (CGFloat(self.currentIndex) - offset).rounded()
                            currentIndex = min(max(Int(newIndex), 0), pageCount - 1)
                            translation = 0
                        })
                )
            )
        }
    }
}

//struct PagerDummyView: View {
//    @State private var currentIndex = 0
//    @State private var translation: CGFloat = .zero
//
//    var body: some View {
//        PagerView(pageCount: 3, currentIndex: $currentIndex, translation: $translation, externalDragGesture: exter, content: {
//            Color.red
//            Color.blue
//            Color.green
//        })
//    }
//}
//
//struct PagerView_Previews: PreviewProvider {
//    static var previews: some View {
//        PagerDummyView()
//    }
//}
