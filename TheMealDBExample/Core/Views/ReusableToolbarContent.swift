//
//  ReusableToolbarContent.swift
//  TheMealDBExample
//
//  Created by Enchappolis on 8/19/24.
//

import SwiftUI

struct ReusableToolbarContent: ToolbarContent {
    
    @Environment(\.dismiss) var dismiss
    
    private let action: (() -> Void)?
    private let imageSymbol: ImageSymbols
    
    init(imageSymbol: ImageSymbols, action: (() -> Void)? = nil) {
        self.imageSymbol = imageSymbol
        self.action = action
    }
    
    var body: some ToolbarContent {
        createToolbarItem()
    }
    
    @ToolbarContentBuilder
    func createToolbarItem() -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button(action: {
                dismiss()
                action?()
            }, label: {
                imageSymbol.image
                    .font(.title2)
                    .foregroundStyle(.gray.opacity(0.8))
            })
        }
    }
}
