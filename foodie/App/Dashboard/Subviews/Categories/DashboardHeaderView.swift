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
                .font(.title)
            
            Spacer()
            
            Button(action: action) {
                Image(systemName: "list.bullet.circle")
                    .font(.title)
            }
            
        }
        .padding()
        .background(ColorStyle.appColor)
    }
}

// MARK: Preview

struct DashboardHeaderView_Preview: PreviewProvider {
    static var previews: some View {
        DashboardHeaderView(action: {})
    }
}
