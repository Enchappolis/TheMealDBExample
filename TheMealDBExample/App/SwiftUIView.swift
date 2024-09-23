//
//  SwiftUIView.swift
//  TheMealDBExample
//
//  Created by Enchappolis on 8/19/24.
//

import SwiftUI

struct SwiftUIView: View {
    
    @State var isActive: Bool = false

    var body: some View {
        
        ZStack {
            
            LaunchScreenColor.launchScreenColor
                .ignoresSafeArea()
            
            if self.isActive && isProduction() {
                DessertView()
            } else if isProduction() {
                Image("Lauchicon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            } else {
                EmptyView()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
    
    private func isProduction() -> Bool {
        return NSClassFromString("XCTestCase") == nil
    }
}

#Preview {
    SwiftUIView()
}
