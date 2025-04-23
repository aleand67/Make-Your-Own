//
//  Data.swift
//  Make Your Own
//
//  Created by Alejandro Andreotti on 3/14/25.
//

import SwiftUI

enum fractions: String, Codable, CaseIterable {
    case half
    case whole
    
    var image: Image {
        switch self {
            case .half: return Image("half")
            case .whole: return Image("whole")
        }
    }
    
    var localizedName: String {
        if #available(macOS 12, iOS 15, *) {
            return String(localized: String.LocalizationValue(rawValue))
        }
        else {
            return NSLocalizedString(rawValue, comment: "")
        }
    }
}

struct Ingredient {
    var name: String?
    var selected: Bool
}

struct Pizza: Identifiable {
    var id = UUID()
    var name: String
    var size: fractions
    var ingredientList: [Ingredient]
    var instructions: String
    var done: Bool
    
    static let samplePizza = Pizza(
        id: UUID(),
        name: "",
        size: .whole,
        ingredientList: zip(starterIngredients, Array(repeating: false, count: starterIngredients.count)).map(Ingredient.init),
        instructions: "",
        done: false)
    
    static func starterPizza(ingredients: [String]) -> Pizza {
        Pizza(
            id: UUID(),
            name: "",
            size: .whole,
            ingredientList: zip(ingredients, Array(repeating: false, count: ingredients.count)).map(Ingredient.init),
            instructions: "",
            done: false
        )
    }
}

struct AnimatePill: ButtonStyle {
    @Environment(\.isEnabled) var isEnabled
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.largeTitle)
            .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
            .background(isEnabled ? (configuration.role == .destructive ? Color.red : Color.blue) : .gray)
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

struct TextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .autocorrectionDisabled(true)
            .font(Font.largeTitle)
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray))
            .foregroundColor(Color.white)
    }
}

extension View {
    func textFieldStyle() -> some View {
        self.modifier(TextFieldStyle())
    }
}

extension Array: @retroactive RawRepresentable where Element: Codable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode([Element].self, from: data)
        else { return nil }
        self = result
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
}

struct CheckboxToggle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Button {
                configuration.isOn.toggle()
            } label: {
                Image(systemName: configuration.isOn ? "checkmark.square" : "square")
            }
            .padding(5)
            .font(.title)
            .accentColor(.white)
            
            configuration.label
        }
    }
}

let starterIngredients = [
    String(localized: "Tomato Sauce🥫"),
    String(localized: "Onion Sauce 🧅"),
    String(localized: "Mozzarella ⚪️"),
    String(localized: "Goat Cheese 🐐 🧀"),
    String(localized: "Tomatoes 🍅"),
    String(localized: "Mushrooms 🍄‍🟫"),
    String(localized: "Parmegiano 🧀"),
    String(localized: "Garlic 🧄"),
    String(localized: "Basil 🌿"),
    String(localized: "Pepperoni 🍕"),
    String(localized: "Olives 🫒"),
    String(localized: "Anchovies 🐟"),
    String(localized: "Pineapple 🍍"),
    String(localized: "Bacon 🥓"),
    String(localized: "Jalapeño 🌶️"),
]
