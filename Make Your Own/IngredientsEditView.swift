//
//  IngredientsEditView.swift
//  Make Your Own
//
//  Created by Alejandro Andreotti on 4/15/25.
//

import SwiftUI

struct IngredientsEditView: View {
    
    @AppStorage("ingredients") var ingredients = starterIngredients
    @AppStorage("ingredientsDone") var ingredientsDone: Bool = false
    @State private var addingIngredient = false
    @State private var newIngredient = ""
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach ($ingredients, id: \.self, editActions: .all) { $ingredient in
                        Text(ingredient)
                    }
                    .onDelete(perform: delete)
                    .onMove(perform: move)
                } 
                Button("+ ingredient") {
                    addingIngredient.toggle()
                }
            }
            .navigationTitle("Ingredients")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Start Ordering!") {
                        ingredientsDone = true
                    }
                }
            }
        }
        .alert("New Ingredient", isPresented: $addingIngredient) {
            TextField("Ingredient", text: $newIngredient)
            Button("Cancel", role: .cancel) {
                newIngredient = ""
            }
            Button("Add") {
                if !newIngredient.isEmpty && !ingredients.contains(newIngredient) { // && clause to prevent repeats
                    ingredients.append(newIngredient)
                    newIngredient = "" //clear TextField
                } else {newIngredient = ""} //clear TextField if repeated
            }
        }
    }
    
    func delete(indexSet: IndexSet) {
        ingredients.remove(atOffsets: indexSet)
    }
    
    func move(from source: IndexSet, to destination: Int) {
        ingredients.move(fromOffsets: source, toOffset: destination)
    }
}


#Preview {
    IngredientsEditView()
}
