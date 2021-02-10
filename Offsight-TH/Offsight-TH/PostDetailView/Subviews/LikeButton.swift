//
//  LikeButton.swift
//  Offsight-TH
//
//  Created by Vishal Singh on 11/02/21.
//

import SwiftUI

struct LikesButton: View {

    let numberOfLikes: Int
    let isLiked: Bool
    let action: () -> ()
    
    var imageName: String {
        isLiked ? "suit.heart.fill" : "suit.heart"
    }

    private let linearGradient = LinearGradient(Theme.Col.blueStart, Theme.Col.blueEnd)
    private let shadowSize: CGFloat = 2.0
    private let padding: CGFloat = 60

    var body: some View {
        Button(action: {
            self.action()
        }) {
            HStack(alignment: .center, spacing: 5) {
                Image(systemName: imageName)
                        .font(.body)
                        .foregroundColor(.pink)
                Text("\(numberOfLikes + (isLiked ? 1 : 0))")
                        .font(.body)
                        .foregroundColor(.pink)
                        .shadow(radius: 2)
            }
            .padding()
        }
        .background(linearGradient)
        .cornerRadius(60.0)
        .shadow(color: Theme.Col.shadowCasted, radius: shadowSize, x: shadowSize, y: shadowSize)
    }
}
