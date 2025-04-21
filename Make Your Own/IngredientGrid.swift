//
//  IngredientGrid.swift
//  Make Your Own
//
//  Created by Alejandro Andreotti on 4/15/25.
//

import SwiftUI

let columns = [GridItem](repeating: GridItem(.flexible(), spacing: 20), count:  UIDevice.current.userInterfaceIdiom == .pad ? 3 : 1)

struct IngredientGrid: View {
    
    @Binding var order: Pizza
    
    var body: some View {
        
        LazyVGrid(columns: columns, alignment: .leading) {
            ForEach($order.ingredientList, id: \.name) { $ingredient in
                Toggle(ingredient.name!, isOn: $ingredient.selected)
                    .font(.title)
                    .disabled(order.done)
                    .showView(ingredient.selected || !order.done)
                }
            .toggleStyle(CheckboxToggle())
            }
            .padding(.horizontal)
    }
}

#Preview {
    @Previewable @State var order = Pizza.samplePizza
    IngredientGrid(order: $order)
}
