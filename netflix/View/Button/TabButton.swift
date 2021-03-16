//
//  SmallVerticalButton.swift
//  netflix
//
//  Created by Zach Bazov on 15/03/2021.
//

import SwiftUI

struct TabButton: View {
    
    var text: String
    
    var image: String
    var offImage: String?
    
    var isOn: Bool?
    
    var imageName: String? {
        if isOn ?? true {
            return image
        } else {
            return offImage
        }
    }
    
    
    
    var action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            VStack {
                Image(systemName: imageName ?? image)
                    .foregroundColor(.white)
                    .padding(.bottom, 2)
                
                Text(text)
                    .foregroundColor(.white)
                    .font(.system(size: 14))
                    .bold()
            }
        })
    }
}

struct TabButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            TabButton(text: "My List", image: "checkmark", offImage: "plus", isOn: true) {
                //
            }
        }
    }
}
