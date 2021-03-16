//
//  SearchBarView.swift
//  netflix
//
//  Created by Zach Bazov on 16/03/2021.
//

import SwiftUI

struct SearchBarView: View {
    
    @State private var text: String = ""
    
    @State private var isEditing = true
    
    @State private var isLoading = false
    
    let screen = UIScreen.main.bounds
    
    var body: some View {
        ZStack(alignment: .leading) {
            
            Color.graySearchBg
                .frame(width: screen.width - 24 - screen.width / 6, height: 36)
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
                    .onChange(of: text, perform: { value in
                        isEditing = true
                    })
                
                if !text.isEmpty {
                    if isLoading {
                        Button(action: {
                            text = ""
                        }, label: {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .padding(.trailing, 16)
                        })
                    } else {
                        Button(action: {
                            text = ""
                        }, label: {
                            Image(systemName: "xmark.circle.fill")
                                .frame(width: 36, height: 36)
                                .background(Color.graySearchBg)
                                .foregroundColor(.graySearchText)
                                .cornerRadius(8.0)
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
            SearchBarView()
        }
    }
}
