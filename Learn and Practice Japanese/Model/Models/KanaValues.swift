//
//  KanaValues.swift
//  Learn and Practice Japanese
//
//  Created by Darya Martynenko on 04.08.2023.
//

import Foundation

struct KanaValue {
    let romaji: String
    let hiragana: String
    let katakana: String
    let cycle: Int64 = 0
    let correct: Int64 = 0
    let incorrect: Int64 = 0
    let isShown: Bool = false
}


