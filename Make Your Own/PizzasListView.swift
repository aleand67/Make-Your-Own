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
    @AppStorage("ingredientsSet") var ingredientsSet = false
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                ForEach($orders.indices, id: \.self) { i in
                    ScrollView (.vertical) {
                        PizzaOrdering(
                            orders: $orders,
                            order: $orders[i],
                            pizzaOrderedSplash: $pizzaOrderedSplash,
                            pizzaOwnerName: $pizzaOwnerName)
                    } //need to use indices for tagging tab purposes
                    .tag(i) //tag with array index
                    .tabItem{ Text("\(orders[i].name)") }
                }
                Button(role: orders.count > 1 ? .destructive : .cancel) {
                    if orders.count > 1 { showAlert = true
                    } else {
                        ingredientsSet = false
                    }
                } label: {orders.count > 1 ? Text("Ok. Party Over.") : Text("Edit Ingredients")}
                .buttonStyle(AnimatePill())
                .tag(-1)
                .tabItem { Text("Done") }
                .alert("You Sure?", isPresented: $showAlert) {
                    Button("Yes. I'm done making pizzas.", role: .destructive) {
                        ingredientsSet = false
                    }
                    Button("No. Go back to making pizzas.", role: .cancel) {
                        selectedTab = 0
                    }
                } message: { Text("Can't Undo") }
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
    PizzasListView(orders: orders, ingredientsSet: true)
}
