//
//  DefaultButtonStyle.swift
//  TheMealDBExample
//
//  Created by Enchappolis on 8/19/24.
//

import SwiftUI

struct DefaultButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(ColorTheme.buttonBackground)
            .foregroundColor(ColorTheme.buttonText)
            .font(.headline)
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

extension ButtonStyle where Self == DefaultButtonStyle {
    static var custom: Self { Self() }
}
