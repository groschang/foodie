//
//  PhotoPlaceholder.swift
//  foodie
//
//  Created by Konrad Groschang on 24/01/2023.
//

import SwiftUI

struct PhotoPlaceholder: View {
    
    var body: some View {
        ProgressView()
            .modifier(PhotoPlaceholderStyle())
    }
}
