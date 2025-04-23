//
//  PizzasListView.swift
//  Make Your Own
//
//  Created by Alejandro Andreotti on 3/14/25.
//

import SwiftUI

struct PizzasListView: View {

    @State var orders: [Pizza]
    @State var selectedTab = 0
    @State var pizzaOrderedSplash = false
    @State var pizzaOwnerName = ""
    @State private var showAlert: Bool = false
    @AppStorage("ingredientsDone") var ingredientsDone = false
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                ForEach($orders.indices, id: \.self) { i in
                    ScrollView (.vertical) {
                        PizzaRecipeView(
                            orders: $orders,
                            order: $orders[i],
                            pizzaOrderedSplash: $pizzaOrderedSplash,
                            pizzaOwnerName: $pizzaOwnerName)
                    } //need to use indices for tagging tab purposes
                    .tag(i) //tag with array index
                    .tabItem{ Text("\(orders[i].name)") }
                }
                Button("Ok. Party over.", role: .destructive) {
                    showAlert = true
                }
                .buttonStyle(AnimatePill())
                .tag(-1)
                .tabItem { Text("Done") }
                .alert("You Sure?", isPresented: $showAlert) {
                    Button("Yes. I'm done making pizzas.", role: .destructive) {
                        ingredientsDone = false
                    }
                    Button("No. Go back to making pizzas.", role: .cancel) {
                        selectedTab = 0
                    }
                } message: { Text("Can't Undo") }
                    .showView(orders.count > 1) //only show if there's at least one pizza made
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            .ignoresSafeArea()
            .id(orders.count) //This helps with appending array within ForEach that changes number of tabs - not sure why/how
            
            PizzaOrderedSplash(name: pizzaOwnerName, pizzaOrderedSplash: $pizzaOrderedSplash)
            .showView(pizzaOrderedSplash)
        }
    }
}

#Preview {
    @Previewable @State var orders = [Pizza.samplePizza]
    PizzasListView(orders: orders, ingredientsDone: true)
}
