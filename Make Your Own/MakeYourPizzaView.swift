//
//  MakeYourPizzaView.swift
//  Make Your Own
//
//  Created by Alejandro Andreotti on 3/14/25.
//

import SwiftUI
import SwiftData

struct MakeYourPizzaView: View {
    
    @State private var orders = [starterPizza]
    @FocusState private var instructionsFocused: Bool
    
    var body: some View {
        TabView {
            ForEach($orders.reversed()) { $order in
                ScrollView (.vertical) {
                    VStack(alignment: .center){
                        Text(order.done ? "\(order.name)'s Pizza" : "Make Your Own")
                            .font(.system(size: 60))
                            .padding(10)
                        
                        ZStack(alignment: .leading){
                            TextField("", text: $order.name)
                                .font(Font.largeTitle)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray))
                                .foregroundColor(Color.white)
                                .padding()
                            
                            Text("Your Name")
                                .font(Font.largeTitle)
                                .padding(30)
                                .foregroundStyle(Color.white.opacity(0.6))
                                .showView(order.name.isEmpty)
                        }
                        .showView(!order.done)//Textfield for Name
                        
                        Divider()
                        Spacer()
                        
                        Text("How much are you going to eat?").font(Font.title)
                        
                        Picker("Size", selection: $order.size) {
                            ForEach(fractions.allCases, id: \.self) { fraction in
                                Text(fraction.rawValue)
                            }
                        }
                        .pickerStyle(.segmented)
                        
                        Spacer()
                        Divider()
                        
                        Text("Make your choices:")
                            .font(.system(size: 30))
                        
                        HStack{
                            Spacer()
                            VStack{
                                Toggle("Tomato Sauce", isOn: $order.tomatoSauce)
                                    .disabled(order.done)
                                    .frame(width: 200)
                                Toggle("Onion Sauce", isOn: $order.onionSauce)
                                    .disabled(order.done)
                                    .frame(width: 200)
                                Toggle("Mozzarella", isOn: $order.mozzarella)
                                    .disabled(order.done)
                                    .frame(width: 200)
                                Toggle("Goat Cheese", isOn: $order.goatCheese)
                                    .disabled(order.done)
                                    .frame(width: 200)
                            }
                            Spacer()
                            VStack{
                                Toggle("Cherry Tomatoes", isOn: $order.cherryTomatoes)
                                    .disabled(order.done)
                                    .frame(width: 200)
                                Toggle("Pepperoni", isOn: $order.pepperoni)
                                    .disabled(order.done)
                                    .frame(width: 200)
                                Toggle("Mushrooms", isOn: $order.mushrooms)
                                    .disabled(order.done)
                                    .frame(width: 200)
                                Toggle("Red Peppers", isOn: $order.redPeppers)
                                    .disabled(order.done)
                                    .frame(width: 200)
                            }
                            Spacer()
                            VStack{
                                Toggle("Artichoke Hearts", isOn: $order.artichokeHearts)
                                    .disabled(order.done)
                                    .frame(width: 200)
                                Toggle("Anchovies", isOn: $order.anchovies)
                                    .disabled(order.done)
                                    .frame(width: 200)
                                Toggle("Olives", isOn: $order.olives)
                                    .disabled(order.done)
                                    .frame(width: 200)
                                Toggle("Parmigiano", isOn: $order.parmigiano)
                                    .disabled(order.done)
                                    .frame(width: 200)
                            }
                            Spacer()
                        }
                        
                        Divider()
                        
                        ZStack(alignment: .leading) {
                            TextField("", text: $order.instructions)
                                .focused($instructionsFocused)
                                .disabled(order.done)
                                .font(Font.title)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray))
                                .foregroundColor(Color.white)
                                .padding()
                            
                            Text("Special Instructions")
                                .font(Font.largeTitle)
                                .padding(30)
                                .foregroundStyle(Color.white.opacity(0.6))
                                .showView(order.instructions.isEmpty)
                        }//TextField for Special Instructions
                        
                        Button("I want it NOW!") {
                            order.done = true
                            instructionsFocused = false
                            orders.append(Pizza(id: UUID(), name: "", size: .half, tomatoSauce: false, onionSauce: false, mozzarella: false, goatCheese: false, pepperoni: false, cherryTomatoes: false, artichokeHearts: false, mushrooms: false, olives: false, anchovies: false, redPeppers: false, parmigiano: false, instructions: "", done: false))
                        }
                        .showView(!order.done)
                        .buttonStyle(AnimatePill())
                        
                        Spacer()
                    }
                    .tabItem{Text("\(order.name)")}
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    MakeYourPizzaView()
}
