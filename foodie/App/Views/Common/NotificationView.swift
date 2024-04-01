//
//  NotificationView.swift
//  foodie
//
//  Created by Konrad Groschang on 27/03/2024.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

struct NotificationView: View {

    let notification: PushNotification
    let action: VoidAction

    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {

            if let title = notification.title {
                Text(title)
                    .title3()
                    .foregroundStyle(AppStyle.darkGray)
                    .padding(5)
            }

            if let subtitle = notification.subtitle {
                Text(subtitle)
                    .foregroundStyle(AppStyle.darkGray)
                    .padding(.bottom, 5)
            }

            if let body = notification.body {
                Text(body)
                    .foregroundStyle(AppStyle.darkGray)
                    .subtitle2()
            }

            Button(action: action) {
                Text("OK")
                    .bold()
            }
            .foregroundColor(.black)
            .padding(6)

        }
        .padding()
        .frame(minWidth: 200, minHeight: 120)
        .background(AppStyle.white)
        .cornerRadius(21)
        .defaultShadow()
    }
}

#Preview {

    struct Preview: View {

        @State var notification = PushNotification.stub
        @State var showPopup = false {
            didSet {
                if showPopup == false {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        notification = .random()
                    }
                }
            }
        }

        var body: some View {
            VStack {
                Button("Show Popup") {
                    notification = .random()
                    showPopup.toggle()
                }
                Spacer()
            }
            .popup(isPresented: $showPopup) {
                NotificationView(
                    notification: notification,
                    action: { showPopup.toggle() }
                )
            }
        }
    }


    return Preview()

}
