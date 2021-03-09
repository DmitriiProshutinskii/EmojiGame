//
//  EmojiMemoryGame.swift
//  StanfordCourse
//
//  Created by Физтех.Радио on 23.02.2021.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    
    func createCardContent(pairIndex: Int) -> String {
        return "😀"
    }
    
    private static func createMemoryGame() -> MemoryGame<String>{
        let emojiArray: Array<String> = ["🥰", "😂", "🤓"]
        
        return MemoryGame<String>(numberOfPairsOfCards: emojiArray.count) {pairIndex  in return emojiArray[pairIndex]}
    }
        
    
    // MARK: - Access to the Model
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    
    //MARK: - Intents
    func choose(card:MemoryGame<String>.Card)
    {
        model.choose(card: card)
    }
    
    func resetGame()
    {
        model = EmojiMemoryGame.createMemoryGame()
    }
    
}
