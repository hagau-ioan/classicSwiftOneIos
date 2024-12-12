//
//  ThemeColors.swift
//  ClassicSwiftOne
//
//  Created by Ioan Hagau on 26.08.2024.
//

import SwiftUI
import Foundation

extension Color {
//    static let baseWhite = Color("isabelline")
//    static let baseGrey = Color("smoke")
//    static let baseYellow = Color("saffron")
}

extension UIColor {
//    static let baseWhite = Color(named: "isabelline")
    static let baseGrey = UIColor.gray
    static let baseYellow = UIColor.yellow


    private static func Color(named key: String) -> UIColor {
       if let color = UIColor(named: key, in: .main, compatibleWith: nil) {
           return color
       }

       return .black
    }
}
