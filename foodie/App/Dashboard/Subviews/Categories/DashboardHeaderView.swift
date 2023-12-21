//
//  DashboardHeaderView.swift
//  foodie
//
//  Created by Konrad Groschang on 11/07/2023.
//

import SwiftUI

struct DashboardHeaderView: View {

    var action: () -> Void
    
    var body: some View {
        HStack {
            Text("Hello, World!")
                .title()

            Spacer()
            
            Button(action: action) {
                Image(systemName: "list.bullet.circle")
                    .font(.title)
            }
            
        }
        .padding()
        .background(AppStyle.background)
        .foregroundStyle(AppStyle.light)
    }
}

// MARK: Preview

struct DashboardHeaderView_Preview: PreviewProvider {
    static var previews: some View {
        DashboardHeaderView(action: {})
    }
}
