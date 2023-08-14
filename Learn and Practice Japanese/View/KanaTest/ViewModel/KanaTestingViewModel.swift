//
//  KanaTestingViewModel.swift
//  Learn and Practice Japanese
//
//  Created by Darya Martynenko on 04.08.2023.
//

import Foundation
import UIKit

class KanaTestingViewModel {
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    var kanas: [Kana]?
    
    func fetchKana() {
        do {
            self.kanas = try context?.fetch(Kana.fetchRequest())
            
            if kanas?.count == 0 {
                addKanaToCoreData()
            }
        }
        catch {
            print("Some error")
        }
    }
    
    func getRomajiValue() -> (romaji: String, hiragana: String, katakana: String) {
        guard let kanas = kanas else {
            return (
                romaji: "",
                hiragana: "",
                katakana: ""
            )
        }
        let randomKana = kanas.randomElement()
        return (
            romaji: randomKana?.romaji ?? "",
            hiragana: randomKana?.hiragana ?? "",
            katakana: randomKana?.katakana ?? ""
        )
    }
    
    func getKanaValue() -> KanaTest? {
        guard let kanas = kanas else {
            return nil
        }

        let randomKanaElement = KanaElement.allCases.randomElement()
        let kanaRandom = kanas.randomElement()
        var kanaUnderTest: String?
        let answerString = "\(kanaRandom?.hiragana ?? "") - \(kanaRandom?.katakana! ?? "") - \(kanaRandom?.romaji  ?? "")"
        var answers: (String, Set<String>)?
        
        switch randomKanaElement {
        case .romaji:
            kanaUnderTest = kanaRandom?.romaji
            answers = getAnswers(elements: [.hiragana, .katakana], kanaDB: kanaRandom!)
        case .hiragana:
            kanaUnderTest = kanaRandom?.hiragana
            answers = getAnswers(elements: [.romaji, .katakana], kanaDB: kanaRandom!)
        case .katakana:
            kanaUnderTest = kanaRandom?.katakana
            answers = getAnswers(elements: [.hiragana, .romaji], kanaDB: kanaRandom!)
        case .none:
            break
        }
        
        guard let answers = answers else { return nil }
        var answersArray: Array<String> = []
        
        for item in answers.1 {
            answersArray.append(item)
        }
        
        return KanaTest(
            kanaUnderTest: kanaUnderTest ?? "",
            optionOne: answersArray[0],
            optionTwo: answersArray[1],
            optionThree: answersArray[2],
            optionFour: answersArray[3],
            correctAnswer: answers.0,
            answerString: answerString
        )
    }
    
    private func getAnswers(elements: [KanaElement], kanaDB: Kana) -> (String, Set<String>) {
        let kana = elements.randomElement()
        var correctAnswer: String?
        var options = Set<String>()
        
        switch kana {
        case .romaji:
            correctAnswer = kanaDB.romaji
            options.insert(correctAnswer!)
            while options.count < 4 {
                if let element = getRandomKana(kanas: kanas!, kanaElement: .romaji),
                   !options.contains(element) {
                    options.insert(element)
                }
            }
        case .hiragana:
            correctAnswer = kanaDB.hiragana
            options.insert(correctAnswer!)
            while options.count < 4 {
                if let element = getRandomKana(kanas: kanas!, kanaElement: .hiragana),
                   !options.contains(element) {
                    options.insert(element)
                }
            }
        case .katakana:
            correctAnswer = kanaDB.katakana
            options.insert(correctAnswer!)
            while options.count < 4 {
                if let element = getRandomKana(kanas: kanas!, kanaElement: .katakana),
                   !options.contains(element)
                {
                    options.insert(element)
                }
            }
        case .none:
            break
        }

        return (correctAnswer!, options)
    }
}

private extension KanaTestingViewModel {
    private func addKanaToCoreData() {
        guard let context = context else { return }
        
        let kanaValues = getKanaValues()
        
        for kanaValue in kanaValues {
            let kiKana = Kana(context: context)
            kiKana.romaji = kanaValue.romaji
            kiKana.hiragana = kanaValue.hiragana
            kiKana.katakana = kanaValue.katakana
            
            do {
                if context.hasChanges {
                    try context.save()
                }
            }
            catch {
                print("Failed save data")
            }
        }
        
        self.fetchKana()
    }
    
    private func getRandomKana(kanas: [Kana], kanaElement: KanaElement) -> String? {
        var element: String?
        
        switch kanaElement {
        case .romaji:
            element = kanas.randomElement()?.romaji
        case .hiragana:
            element = kanas.randomElement()?.hiragana
        case .katakana:
            element = kanas.randomElement()?.katakana
        }
        return element
    }
}

private extension KanaTestingViewModel {
    private func getKanaValues() -> [KanaValue] {
        return [
            KanaValue(romaji: "a", hiragana: "あ", katakana: "ア"),
            KanaValue(romaji: "i", hiragana: "い", katakana: "イ"),
            KanaValue(romaji: "u", hiragana: "う", katakana: "ウ"),
            KanaValue(romaji: "e", hiragana: "え", katakana: "エ"),
            KanaValue(romaji: "o", hiragana: "お", katakana: "オ"),
            KanaValue(romaji: "ka", hiragana: "か", katakana: "カ"),
            KanaValue(romaji: "ki", hiragana: "き", katakana: "キ"),
            KanaValue(romaji: "ku", hiragana: "く", katakana: "ク"),
            KanaValue(romaji: "ke", hiragana: "け", katakana: "ケ"),
            KanaValue(romaji: "ko", hiragana: "こ", katakana: "コ"),
            KanaValue(romaji: "sa", hiragana: "さ", katakana: "サ"),
            KanaValue(romaji: "shi", hiragana: "し", katakana: "シ"),
            KanaValue(romaji: "su", hiragana: "す", katakana: "ス"),
            KanaValue(romaji: "se", hiragana: "せ", katakana: "セ"),
            KanaValue(romaji: "so", hiragana: "そ", katakana: "ソ"),
            KanaValue(romaji: "ta", hiragana: "た", katakana: "タ"),
            KanaValue(romaji: "chi", hiragana: "ち", katakana: "チ"),
            KanaValue(romaji: "tsu", hiragana: "つ", katakana: "ツ"),
            KanaValue(romaji: "te", hiragana: "て", katakana: "テ"),
            KanaValue(romaji: "to", hiragana: "と", katakana: "ト"),
            KanaValue(romaji: "na", hiragana: "な", katakana: "ナ"),
            KanaValue(romaji: "ni", hiragana: "に", katakana: "ニ"),
            KanaValue(romaji: "nu", hiragana: "ぬ", katakana: "ヌ"),
            KanaValue(romaji: "ne", hiragana: "ね", katakana: "ネ"),
            KanaValue(romaji: "no", hiragana: "の", katakana: "ノ"),
            KanaValue(romaji: "ma", hiragana: "ま", katakana: "マ"),
            KanaValue(romaji: "mi", hiragana: "み", katakana: "ミ"),
            KanaValue(romaji: "mu", hiragana: "む", katakana: "ム"),
            KanaValue(romaji: "me", hiragana: "め", katakana: "メ"),
            KanaValue(romaji: "mo", hiragana: "も", katakana: "モ"),
            KanaValue(romaji: "ya", hiragana: "や", katakana: "ヤ"),
            KanaValue(romaji: "yu", hiragana: "ゆ", katakana: "ユ"),
            KanaValue(romaji: "yo", hiragana: "よ", katakana: "ヨ"),
            KanaValue(romaji: "ra", hiragana: "ら", katakana: "ラ"),
            KanaValue(romaji: "ri", hiragana: "り", katakana: "リ"),
            KanaValue(romaji: "ru", hiragana: "る", katakana: "ル"),
            KanaValue(romaji: "re", hiragana: "れ", katakana: "レ"),
            KanaValue(romaji: "ro", hiragana: "ろ", katakana: "ロ"),
            KanaValue(romaji: "wa", hiragana: "わ", katakana: "ワ"),
            KanaValue(romaji: "wo", hiragana: "を", katakana: "ヲ"),
            KanaValue(romaji: "n/m", hiragana: "ん", katakana: "ン")
        ]
    }
}
