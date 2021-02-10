//
//  Theme.swift
//  Offsight-TH
//
//  Created by Vishal Singh on 11/02/21.
//

import Foundation
import SwiftUI

enum Theme {
    enum Col {
        static let element1 = Color("element1")
        static let element2 = Color("element2")

        static let background = Color("background")

        static let lightSource = Color("lightSource")
        static let shadowCasted = Color("shadowCasted")
        
        static let redStart = Color("redStart")
        static let redEnd = Color("redEnd")
        
        static let blueStart = Color("blueStart")
        static let blueEnd = Color("blueEnd")

        static let greenStart = Color("greenStart")
        static let greenEnd = Color("greenEnd")

        static let textColor = Color("text")
    }
}

extension LinearGradient {
    init(_ colors: Color..., startPoint: UnitPoint = .topLeading, endPoint: UnitPoint = .bottomTrailing) {
        self.init(gradient: Gradient(colors: colors), startPoint: startPoint, endPoint: endPoint)
    }
}
