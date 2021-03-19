//
//  SearchBarView.swift
//  netflix
//
//  Created by Zach Bazov on 16/03/2021.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var text: String
    
    @State private var isEditing = true
    
    @Binding var isLoading: Bool
    
    let screen = UIScreen.main.bounds
    
    var body: some View {
        ZStack(alignment: .leading) {
            
            Color.graySearchBg
                .frame(width: screen.width - screen.width / 5, height: 36)
                .cornerRadius(8.0)
            
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color.graySearchText)
                    .padding(.leading, 8)
                    .padding(.trailing, 4)
                
                TextField("Search", text: $text)
                    .frame(height: 36)
                    .background(Color.graySearchBg)
                    .foregroundColor(.white)
                    .cornerRadius(8.0)
                    .onTapGesture {
                        isEditing = true
                    }
                    .animation(.default)
                
                if !text.isEmpty {
                    if isLoading {
                        Button(action: {
                            text = ""
                        }, label: {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .frame(width: 36, height: 36)
                                .padding(.trailing, 2)
                        })
                    } else {
                        Button(action: {
                            text = ""
                        }, label: {
                            Image(systemName: "xmark.circle.fill")
                                .frame(width: 36, height: 36)
                                .foregroundColor(.graySearchText)
                        })
                    }
                }
                
                if isEditing {
                    Button(action: {
                        isEditing = false
                        text = ""
                        hideKeyboard()
                    }, label: {
                        Text("Cancel")
                            .foregroundColor(.white)
                    })
                    .transition(.move(edge: .trailing))
                    .animation(.default)
                } 
            }
        }
        .padding(.horizontal, 8)
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            SearchBarView(text: .constant(""), isLoading: .constant(false))
        }
    }
}
