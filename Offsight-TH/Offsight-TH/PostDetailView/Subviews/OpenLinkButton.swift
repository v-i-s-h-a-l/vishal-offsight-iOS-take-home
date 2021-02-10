//
//  OpenLinkButton.swift
//  Offsight-TH
//
//  Created by Vishal Singh on 11/02/21.
//

import SwiftUI

struct OpenLinkButton: View {

    let action: () -> ()
    
    private let linearGradient = LinearGradient(Theme.Col.greenStart, Theme.Col.greenEnd)
    private let shadowSize: CGFloat = 2.0
    private let padding: CGFloat = 60

    var body: some View {
        Button(action: {
            self.action()
        }) {
            HStack(alignment: .center, spacing: 5) {
                Text("Details")
                        .font(.body)
                        .foregroundColor(.white)
                        .shadow(radius: 2)
            }
            .padding()
        }
        .background(linearGradient)
        .cornerRadius(60.0)
        .shadow(color: Theme.Col.shadowCasted, radius: shadowSize, x: shadowSize, y: shadowSize)
    }
}
