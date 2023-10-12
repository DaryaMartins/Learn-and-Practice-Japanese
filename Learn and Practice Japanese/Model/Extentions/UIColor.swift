//
//  UIColor.swift
//  Learn and Practice Japanese
//
//  Created by Darya Martynenko on 03.08.2023.
//

import UIKit

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
    
    // todo: fix name
    static let accentColor = UIColor(hex: "#a1ddf7ff")
    static let backgroundColor = UIColor(hex: "#dbf4ffff")
    static let wrongAnswerColor = UIColor(hex: "#f57686ff")
    static let correctAnswerColor = UIColor(hex: "#84f597ff")
    static let lineColor = UIColor(hex: "#b8d2deff")
    static let selectedButtonColor = UIColor(hex: "#43a6d1ff")
    static let inkColor = UIColor(hex: "#2081a5ff")
}
