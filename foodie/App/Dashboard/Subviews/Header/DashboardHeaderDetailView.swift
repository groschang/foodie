//
//  DashboardHeaderDetailView.swift
//  foodie
//
//  Created by Konrad Groschang on 11/07/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

struct DashboardHeaderDetailView: View {

    var action: () -> Void

    var body: some View {
        HStack {

            Image(systemName: "person.fill")
                .font(.system(size: 44))
                .frame(width: 44, height: 44)
                .shadow(color: .gray, radius: 10)

            VStack(alignment: .leading) {

                Text("Hello, John Appleseed!")
                    .title3()

                Text("Check new recipes!")
                    .foregroundColor(Color.white)
                    .subtitle3()
            }

            Spacer()

            Button(action: action) {
                Image(systemName: "list.bullet.circle")
                    .font(.title)
                    .tint(.accent)
            }

        }
    }
}

// MARK: Preview

#Preview {
    DashboardHeaderDetailView(action: {})
}
