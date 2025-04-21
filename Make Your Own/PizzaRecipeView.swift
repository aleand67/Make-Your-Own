//
//  PizzaRecipeView.swift
//  Make Your Own
//
//  Created by Alejandro Andreotti on 4/9/25.
//

import SwiftUI

struct PizzaRecipeView: View {
    @Binding var orders: [Pizza]
    @Binding var order: Pizza
    @AppStorage("ingredients") private var ingredients = starterIngredients
    @FocusState private var instructionsFocused: Bool
    
    var body: some View {
        VStack(alignment: .center){
            Text(order.done ? "\(order.name)'s Pizza" : "Make Your Own")
                .font(.system(size: 50))
                .padding(10)
            Divider()
                        
            TextField("", text: $order.name, prompt: Text("Your Name"))
                .textFieldStyle()
                .showView(!order.done)
            
            Divider()
                .frame(height: 20)
            
            Text("How hungry are you?")
                .font(.largeTitle)
                .showView(!order.done)
            
            Picker("Size", selection: $order.size) {
                ForEach(fractions.allCases, id: \.self) { fraction in
                    Text(fraction.localizedName)
                }
            }
            .pickerStyle(.segmented)
            
            Divider()
                .frame(height: 20)
            
            Text("Make your choices:")
                .font(.largeTitle)
                .showView(!order.done)
            
            IngredientGrid(order: $order)
                
            Divider()
                .frame(height: 20)
            
            TextField("", text: $order.instructions, prompt: Text("Special Instructions"))
                .focused($instructionsFocused)
                .disabled(order.done)
                .textFieldStyle()
            
            Divider()
                .frame(height: 20)
            
            Button(order.name.isEmpty ? "I need a name" : "I want it NOW!") {
                order.done = true
                instructionsFocused = false
                orders.insert(
                    Pizza.starterPizza(ingredients: ingredients),
                    at: 0
                )
            }
            .disabled(order.name.isEmpty)
            .buttonStyle(AnimatePill())
            .showView(!order.done)
        }
    }
}

#Preview {
    @Previewable @State var order = Pizza.samplePizza
    @Previewable @State var orders = [Pizza.samplePizza]
    PizzaRecipeView(orders: $orders, order: $order)
}
