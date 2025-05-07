//
//  ContentView.swift
//  Make Your Own
//
//  Created by Alejandro Andreotti on 3/14/25.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("ingredientsSet") private var ingredientsSet: Bool = false
    @AppStorage("ingredients") private var ingredients = starterIngredients
    
    var body: some View {
        ChefsPage()
            .showView(!ingredientsSet)
        PizzasListView(
            orders: [Pizza.starterPizza(ingredients: ingredients)],
            ingredientsSet: ingredientsSet
        )
        .showView(ingredientsSet)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
