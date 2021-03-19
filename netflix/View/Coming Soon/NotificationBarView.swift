//
//  NotificationBarView.swift
//  netflix
//
//  Created by Zach Bazov on 17/03/2021.
//

import SwiftUI

struct NotificationBarView: View {
    
    @Binding var showNotificationList: Bool
    
    var body: some View {
        Button(action: {
            showNotificationList = true
        }, label: {
            HStack {
                Image(systemName: "bell")
                Text("Notifications")
                    .bold()
                Spacer()
                Image(systemName: "chevron.right")
            }
            .font(.system(size: 18, weight: .bold))
        })
        .foregroundColor(.white)
        .padding()
    }
}

struct NotificationBarView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            NotificationBarView(showNotificationList: .constant(false))
        }
    }
}
