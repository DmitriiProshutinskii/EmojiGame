//
//  Cardify.swift
//  StanfordCourse
//
//  Created by Физтех.Радио on 03.03.2021.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    
    private var rotation: Double
    private let cornerRadius : CGFloat = 15.0
    private let lineWidth : CGFloat = 3
    var isFaceUp: Bool {
        rotation < 90
    }
    var animatableData: Double
    {
        get {
            rotation
        }
        set {
            rotation = newValue
        }
    }
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0: 180
    }
    
    func body(content: Content) -> some View {
        ZStack{
            Group{
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: lineWidth)
                content
            }
                .opacity(isFaceUp ? 1:0)
            RoundedRectangle(cornerRadius: cornerRadius)
                .opacity(isFaceUp ? 0:1)
        }
        .rotation3DEffect(Angle.degrees(rotation),
            axis: (0,1,0)
            )
    }    
}

extension View {
    func cardify(isFaceUp: Bool) -> some View{
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
