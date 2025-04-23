//
//  PizzaOrderedSplash.swift
//  Make Your Own
//
//  Created by Alejandro Andreotti on 4/22/25.
//

import SwiftUI

struct PizzaOrderedSplash: View {
    @State private var scale = CGSize(width: 0.8, height: 0.8)
    @State private var opacity = 1.0
    @State var name: String
    @Binding var pizzaOrderedSplash: Bool
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            Image("Pizza")
                .clipShape(Circle())
                .shadow(color: .brown, radius: 20)
                .opacity(opacity)
                .scaleEffect(scale)
            
            Text("\(name)'s pizza coming up!")
                .font(.system(size: 32, weight: .bold, design: .default))
                .foregroundColor(.black)
                .opacity(1 - opacity)
        }
        .transition(.opacity)
        .zIndex(1)//this helps final fade out work
        .onAppear {
            withAnimation(.easeInOut(duration: 1.5)) {
                scale = CGSize(width: 1, height: 1)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation(.easeInOut(duration: 0.35)) {
                    scale = CGSize(width: 50, height: 50)
                    opacity = 0
                }// pizza zoom in and fades out while message fades in
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation { pizzaOrderedSplash.toggle()
                }// message on and then splash fades out
            }
        }
    }
}

#Preview {
    PizzaOrderedSplash(name: "Ale", pizzaOrderedSplash: .constant(true))
}
