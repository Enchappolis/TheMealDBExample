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
            
            if self.isActive {
                DessertView()
            } else {
                Image("Lauchicon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
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
}

#Preview {
    SwiftUIView()
}
