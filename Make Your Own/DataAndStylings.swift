//
//  Data.swift
//  Make Your Own
//
//  Created by Alejandro Andreotti on 3/14/25.
//

import SwiftUI


enum fractions: String, Codable, CaseIterable {
    case fourth
    case half
    case whole
}

struct Pizza: Identifiable {
    var id = UUID()
    var name: String
    var size: fractions
    var tomatoSauce: Bool
    var onionSauce: Bool
    var mozzarella: Bool
    var goatCheese: Bool
    var pepperoni: Bool
    var cherryTomatoes: Bool
    var artichokeHearts: Bool
    var mushrooms: Bool
    var olives: Bool
    var anchovies: Bool
    var redPeppers: Bool
    var parmigiano: Bool
    var instructions: String
    var done: Bool
}

let starterPizza = Pizza(name: "", size: .half, tomatoSauce: false, onionSauce: false, mozzarella: false, goatCheese: false, pepperoni: false, cherryTomatoes: false, artichokeHearts: false, mushrooms: false, olives: false, anchovies: false, redPeppers: false, parmigiano: false, instructions: "", done: false)

struct AnimatePill: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.largeTitle)
            .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
            .background(.blue)
            .foregroundStyle(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
    }
}


extension View {
    @ViewBuilder func showView(_ isShown: Bool = false) -> some View {
        if isShown {
            self.transition(.scale)
        } else {
            EmptyView()
        }
    }
}
