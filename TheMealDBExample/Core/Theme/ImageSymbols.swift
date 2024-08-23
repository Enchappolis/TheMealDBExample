//
//  ImageSymbols.swift
//  TheMealDBExample
//
//  Created by Enchappolis on 8/19/24.
//

import SwiftUI

enum ImageSymbols {
    case chevronBack
    case chevronDown
    case chevronUp
    case close
    
    var image: Image {
        Image(systemName: self.name)
    }
    
    var name: String {
        switch self {
        case .chevronBack:
            "chevron.left.circle.fill"
        case .chevronDown:
            "chevron.down"
        case .chevronUp:
            "chevron.up"
        case .close:
            "x.circle.fill"
        }
    }
}

