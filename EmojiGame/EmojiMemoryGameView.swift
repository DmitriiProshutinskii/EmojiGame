//
//  EmojiMemoryGameView.swift
//  StanfordCourse
//
//  Created by Физтех.Радио on 18.02.2021.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack{
            Grid(items: viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    withAnimation(.easeInOut(duration: 1)) {
                        viewModel.choose(card: card) }
                }
                .padding(5)
            }
            .foregroundColor(.orange)
            .padding()
            
            Button(action:{
                withAnimation(.easeInOut(duration: 1))
                {
                    viewModel.resetGame()
                    
                }},
                   label: {
                Text("New Game").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).foregroundColor(.white)
            }).padding(2)
            .background(Color.red)
            
        }
        
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    var body: some View
    {
        GeometryReader { geometry in
            body(for: geometry.size)
        }
    }
    
    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining))
        {
            animatedBonusRemaining = 0
        }
    }
    
    @ViewBuilder
     private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack()
            {
                if card.isConsuminBonusTime {
                    Pie(startAngle: Angle.degrees(-90), endAngle: Angle.degrees(-animatedBonusRemaining*360-90), clockwise: true).padding(5).opacity(0.4)
                        .onAppear {
                            startBonusTimeAnimation()
                        }
                }
                else {
                    Pie(startAngle: Angle.degrees(-90), endAngle: Angle.degrees(-card.bonusRemaining*360-90), clockwise: true).padding(5).opacity(0.4)
                }
                
                
                Text(card.content).font(Font.system(size: fontSize(size: size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
            }
            .cardify(isFaceUp: card.isFaceUp)
            .transition(.scale)            
        }
        
        
    }
    
    private func fontSize(size: CGSize) -> CGFloat {
        min(size.width, size.height)*scaleFactor
    }
    
    //MARK: - Drawing Constants
    private let spacing : CGFloat = 9.0

    
    private let scaleFactor : CGFloat = 0.7
}













struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(viewModel: game)
    }
}
