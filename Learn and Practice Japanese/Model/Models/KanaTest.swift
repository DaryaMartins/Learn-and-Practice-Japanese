//
//  KanaTest.swift
//  Learn and Practice Japanese
//
//  Created by Darya Martynenko on 07.08.2023.
//

import Foundation

struct KanaTest {
    let kanaUnderTest: String
    let optionOne: String
    let optionTwo: String
    let optionThree: String
    let optionFour: String
    let correctAnswer: String
    let answerString: String
}

enum KanaElement: CaseIterable {
    case romaji, hiragana, katakana
}
