//
//  ErrorView.swift
//  TheMealDBExample
//
//  Created by Enchappolis on 8/19/24.
//

import SwiftUI

struct ErrorView: View {
    
    private let title: String
    private let message: String
    private let buttonText: String
    private let onDismiss: () -> Void
    
    init(title: String, message: String, buttonText: String, onDismiss: @escaping () -> Void) {
        self.title = title
        self.message = message
        self.buttonText = buttonText
        self.onDismiss = onDismiss
    }

    var body: some View {
        VStack {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.red)
            
            Text(message)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()
            
            Button(action: onDismiss) {
                Text(buttonText)
            }
            .buttonStyle(.custom)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ColorTheme.background)
        .padding()
        
    }
}

#Preview {
    ErrorView(title: "Error", message: "message", buttonText: "Reload", onDismiss: {})
}

#Preview("Long text") {
    ErrorView(title: "Error", message: "message Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt", buttonText: "Reload", onDismiss: {})
}
