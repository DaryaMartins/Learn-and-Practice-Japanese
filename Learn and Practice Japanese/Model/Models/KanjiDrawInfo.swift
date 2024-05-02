//
//  KanjiDrawInfo.swift
//  Learn and Practice Japanese
//
//  Created by Darya Martynenko on 02.05.2024.
//

import Foundation

struct KanjiDrawInfo: Decodable {
    let kanji: String
    let meanings: String
    let readingsOn: String
    let readingsKun: String
}
