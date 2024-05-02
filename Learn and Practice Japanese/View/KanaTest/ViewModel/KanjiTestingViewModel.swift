//
//  KanjiTestingViewModel.swift
//  Learn and Practice Japanese
//
//  Created by Darya Martynenko on 02.05.2024.
//

import Foundation
import UIKit

class KanjiTestingViewModel {
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    var kanjiList: [Kanji]?
    
    func fetchKanji() {
        do {
            self.kanjiList = try context?.fetch(Kanji.fetchRequest())
            
            if kanjiList?.count == 0 {
                addKanjiToCoreData()
            }
        }
        catch {
            print("Some error")
        }
    }
    
    func getRandomKanji() -> KanjiDrawInfo? {
        guard let kanji = kanjiList?.randomElement() else { return nil }
        let kanjiValue: KanjiDrawInfo = (KanjiDrawInfo(kanji: kanji.kanji ?? "", meanings: kanji.meanings ?? "", readingsOn: kanji.readingsOn ?? "", readingsKun: kanji.readingsKun ?? ""))
        
        return kanjiValue
    }
}

private extension KanjiTestingViewModel {
    func addKanjiToCoreData() {
        guard let context = context else { return }
        
        let kanjiValues = getKanjiValues()
        
        for kanjiValue in kanjiValues {
            let kanji = Kanji(context: context)
            kanji.kanji = kanjiValue.kanji
            kanji.meanings = kanjiValue.meanings.first
            kanji.jlptLevel = Int16(kanjiValue.jlptNew)
            kanji.readingsOn = kanjiValue.readingsOn.first
            kanji.readingsKun = kanjiValue.readingsKun.first
        }
        
        do {
            if context.hasChanges {
                try context.save()
            }
        }
        catch {
            print("Failed save data")
        }
        
        self.fetchKanji()
        
    }
    
    func getKanjiValues() -> [KanjiValue] {
        let jsonData = readLocalJSONFile(forName: "jlptN5")
        if let data = jsonData {
            if let sampleRecordObj = parse(jsonData: data) {
                return sampleRecordObj.result
            }
        }
        
        return []
    }
    
    func readLocalJSONFile(forName name: String) -> Data? {
        do {
            if let filePath = Bundle.main.path(forResource: name, ofType: "json") {
                let fileUrl = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileUrl)
                return data
            }
        } catch {
            print("error: \(error)")
        }
        return nil
    }
    
    func parse(jsonData: Data) -> KanjiResult? {
        do {
            let decodedData = try JSONDecoder().decode(KanjiResult.self, from: jsonData)
            return decodedData
        } catch {
            print("error: \(error)")
        }
        return nil
    }
}
