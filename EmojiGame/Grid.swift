//
//  Grid.swift
//  StanfordCourse
//
//  Created by Физтех.Радио on 27.02.2021.
//

import SwiftUI

//1. Array of Identifialbe 2. Func that takes one of the identifiable and provides a view.

struct Grid<Item, ItemView>: View where Item: Identifiable, ItemView: View {
    //MARK: - Varibles
    private var items: [Item]
    private var viewForItem: (Item) ->ItemView
     
    init(items:[Item], viewForItem: @escaping (Item) -> ItemView) {
        self.items = items
        self.viewForItem = viewForItem
    }
    
    var body: some View {
        //Geometry Reader позволяет понять, сколько пространства зарезервировано под View
        GeometryReader {
            geometry in body(for: GridLayout(itemCount: items.count, in: geometry.size))
        }
        
    }
    
    private func body(for layout: GridLayout) -> some View {
        ForEach(items) {
            item in self.body(for: item, for: layout)
        }
    }
    
    private func body(for item: Item, for layout: GridLayout) -> some View {
        viewForItem(item)
            .frame(width: layout.itemSize.width, height: layout.itemSize.height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .position(layout.location(ofItemAt: items.firstIndex(of: item)!))
    }
}
