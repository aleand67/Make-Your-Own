//
//  Data.swift
//  Make Your Own
//
//  Created by Alejandro Andreotti on 3/14/25.
//

import Foundation
import SwiftData

enum fractions: String, Codable, CaseIterable {
    case fourth
    case half
    case whole
}

@Model
final class Pizza {
    var id: UUID
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
    
    init(name: String, size: fractions, tomatoSauce: Bool, onionSauce: Bool, mozzarella: Bool, goatCheese: Bool, pepperoni: Bool, cherryTomatoes: Bool, artichokeHearts: Bool, mushrooms: Bool, olives: Bool, anchovies: Bool, redPeppers: Bool, parmigiano: Bool = false, instructions: String = "") {
        self.id = UUID()
        self.name = name
        self.size = size
        self.tomatoSauce = tomatoSauce
        self.onionSauce = onionSauce
        self.mozzarella = mozzarella
        self.goatCheese = goatCheese
        self.pepperoni = pepperoni
        self.cherryTomatoes = cherryTomatoes
        self.artichokeHearts = artichokeHearts
        self.mushrooms = mushrooms
        self.olives = olives
        self.anchovies = anchovies
        self.redPeppers = redPeppers
        self.parmigiano = parmigiano
        self.instructions = instructions
    }
}



