//
//  Extentions.swift
//  StanfordCourse
//
//  Created by Физтех.Радио on 01.03.2021.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(of matching: Element) -> Int? {
        for index in 0..<self.count {
            if(self[index].id == matching.id) {
                return index
            }
        }
        return nil; //TODO: bug!
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
