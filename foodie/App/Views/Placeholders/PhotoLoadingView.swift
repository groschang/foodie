//
//  PhotoLoadingView.swift
//  foodie
//
//  Created by Konrad Groschang on 24/01/2023.
//  Copyright (C) 2024 Konrad Groschang - All Rights Reserved
//

import SwiftUI

struct PhotoLoadingView: View {
    
    var body: some View {
        ModernCircularLoader()
            .modifier(PhotoLoadingViewStyle())
    }
}

// MARK: Preview

struct PhotoPlaceholder_Peviews: PreviewProvider {
    static var previews: some View {
        PhotoLoadingView()
    }
}
