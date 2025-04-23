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
    @Binding var pizzaOrderedSplash: Bool
    @Binding var pizzaOwnerName: String
    @AppStorage("ingredients") private var ingredients = starterIngredients
    @FocusState private var instructionsFocused: Bool
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading){
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
                    .font(.title)
                    .foregroundStyle(.gray)
                    .showView(!order.done)
                
                PickerWithImage(selection: $order.size)
                
                Divider()
                    .frame(height: 20)
                
                Text("Make your choices:")
                    .font(.title)
                    .foregroundStyle(.gray)
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
                
                HStack {
                    Spacer()
                    Button(order.name.isEmpty ? "I need a name" : "I want it NOW!") {
                        order.done = true
                        instructionsFocused = false
                        
                        pizzaOrderedSplash = true
                        pizzaOwnerName = order.name
                        
                        orders.insert(
                            Pizza.starterPizza(ingredients: ingredients),
                            at: 0
                        )
                    }
                    .disabled(order.name.isEmpty)
                    .buttonStyle(AnimatePill())
                    .showView(!order.done)
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var order = Pizza.samplePizza
    @Previewable @State var orders = [Pizza.samplePizza]
    @Previewable @State var pizzaOrderedSplash: Bool = false
    @Previewable @State var pizzaOwnerName: String = ""
    PizzaRecipeView(orders: $orders, order: $order, pizzaOrderedSplash: $pizzaOrderedSplash, pizzaOwnerName: $pizzaOwnerName)
}
