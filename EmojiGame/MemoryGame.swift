//
//  MemoryGame.swift
//  StanfordCourse
//
//  Created by Физтех.Радио on 23.02.2021.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private var indexOfOnlyOneAndOnlyFacedUpCard: Int?
    {
        get{
            return  cards.indices.filter {cards[$0].isFaceUp}.only
        }
        set{
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    mutating func choose(card: Card)
    {
        //Если карта 1 по такому индексу есть, если она перевернута вниз и не выбрана
        if let contentIndex = cards.firstIndex(of: card), !cards[contentIndex].isFaceUp, !cards[contentIndex].isMatched
        {
            //Если карта, которая уже картинкой вверх, есть, то
            if let potentialMatchIndex = indexOfOnlyOneAndOnlyFacedUpCard {
                //Если содержание выбранной карты и карты, которая картинкой вверх совпадают
                if cards[contentIndex].content == cards[potentialMatchIndex].content {
                    cards[contentIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                cards[contentIndex].isFaceUp = true
            }
            //Если же такой карты нет, то
            else {
                indexOfOnlyOneAndOnlyFacedUpCard = contentIndex
            }
        }
    }
    
    init(numberOfPairsOfCards:Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for index in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(index)
            cards.append(Card(content: content, id: index*2))
            cards.append(Card(content: content, id: index*2+1))
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
        
        //MARK: -Bonus Time
        
        var bonusTimeLimit: TimeInterval = 6
        var lastFaceUpDate: Date?
        var pastFaceUpTime: TimeInterval = 0
        
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
        }
        
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        
        var isConsuminBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        private mutating func startUsingBonusTime() {
            if isConsuminBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        private mutating func stopUsingTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
        
    }
    
    
}


