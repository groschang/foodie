//
//  Keyboard.swift
//  foodie
//
//  Created by Konrad Groschang on 07/01/2024.
//

import SwiftUI

extension View {

    func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder), 
            to: nil,
            from: nil,
            for: nil
        )
    }

}
