//
//  DashboardHeaderDetailView.swift
//  foodie
//
//  Created by Konrad Groschang on 11/07/2023.
//

import SwiftUI

struct DashboardHeaderDetailView: View {

    var action: () -> Void

    var body: some View {
        HStack {

            Image(systemName: "person.fill")
                .font(.system(size: 44))
                .frame(width: 44, height: 44)

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
            }

        }
    }
}

// MARK: Preview

struct DashboardHeaderView_Preview: PreviewProvider {
    static var previews: some View {
        DashboardHeaderDetailView(action: {})
    }
}
