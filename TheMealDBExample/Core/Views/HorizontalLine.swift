//
//  HorizontalLine.swift
//  TheMealDBExample
//
//  Created by s on 9/5/24.
//

import SwiftUI

struct HorizontalLine: View {
    var body: some View {
        Rectangle()
            .fill(Color.gray)
            .frame(height: 1)
    }
}

#Preview {
    HorizontalLine()
}
