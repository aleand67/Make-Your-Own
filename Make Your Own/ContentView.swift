//
//  ContentView.swift
//  Make Your Own
//
//  Created by Alejandro Andreotti on 3/14/25.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("ingredientsDone") private var ingredientsDone: Bool = false
    @AppStorage("ingredients") private var ingredients = starterIngredients
    
    var body: some View {
        IngredientsEditView()
            .showView(!ingredientsDone)
        PizzasListView(
            orders: [Pizza.starterPizza(ingredients: ingredients)],
            ingredientsDone: ingredientsDone
        )
        .showView(ingredientsDone)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
