//
//  YouTubeButton.swift
//  TheMealDBExample
//
//  Created by Enchappolis on 8/21/24.
//

import SwiftUI

struct YouTubeButton: View {
    
    private let action: () -> Void
    
    init(action: @escaping () -> Void) {
        self.action = action
    }
    
    var body: some View {
       
        Button(action: {
            action()
        }, label: {
            HStack {
                Image("YouTube_icon")
                    .resizable()
                    .frame(width: 30, height: 20)
                
                Text("Play video")
                    .font(.subheadline)
                    .foregroundStyle(.black)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 6)
        })
        .padding(.vertical, 4)
        .background {
            Color.gray.opacity(0.2)
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    YouTubeButton {
        
    }
}
