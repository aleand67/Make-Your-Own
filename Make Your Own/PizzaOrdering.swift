//
//  PizzaOrdering.swift
//  Make Your Own
//
//  Created by Alejandro Andreotti on 4/9/25.
//

import SwiftUI

struct PizzaOrdering: View {
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
                    .centered()   

                
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
                
                Button(order.name.isEmpty ? "I need a name" : "I want it NOW!") {
                        order.done = true
                        instructionsFocused = false
                        
                        pizzaOrderedSplash = true
                        pizzaOwnerName = order.name
                        
                        if order.size == .half {
                            orders.insert(order, at: orders.count)
                            orders.remove(at: 0)
                        } // put all half pizzas together
                        
                        orders.insert(
                            Pizza.starterPizza(ingredients: ingredients),
                            at: 0
                        )
                    }
                    .centered()
                    .disabled(order.name.isEmpty)
                    .buttonStyle(AnimatePill())
                    .showView(!order.done)
            }
        }
    }
}

#Preview {
    @Previewable @State var order = Pizza.samplePizza
    @Previewable @State var orders = [Pizza.samplePizza]
    @Previewable @State var pizzaOrderedSplash: Bool = false
    @Previewable @State var pizzaOwnerName: String = ""
    PizzaOrdering(orders: $orders, order: $order, pizzaOrderedSplash: $pizzaOrderedSplash, pizzaOwnerName: $pizzaOwnerName)
}
