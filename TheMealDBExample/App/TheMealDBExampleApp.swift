//
//  TheMealDBExampleApp.swift
//  TheMealDBExample
//
//  Created by Enchappolis on 8/19/24.
//

import SwiftUI

@main
struct TheMealDBExampleApp: App {
    
    init() {
        
        #if DEBUG
        print(NSTemporaryDirectory())
        #endif
    }
    
    var body: some Scene {
        WindowGroup {
            SwiftUIView()                
        }
    }
}
