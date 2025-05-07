//
//  PickerWithImage.swift
//  Make Your Own
//
//  Created by Alejandro Andreotti on 4/23/25.
//

import SwiftUI

struct PickerWithImage: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Binding var selection: fractions
        
    var body: some View {
        HStack {
            ForEach(fractions.allCases, id: \.self) { fraction in
                
                Button {
                    selection = fraction
                } label: {
                    VStack{
                        fraction.image
                            .resizable()
                            .scaledToFit()
                            .offset(x: fraction == .half ? 15 : 0)
                        Text(fraction.localizedName)
                            .foregroundStyle(.black)
                            .padding(.bottom, 10)
                    }
                    .containerRelativeFrame([.horizontal, .vertical]) { length, axis in
                        if axis == .horizontal {
                            return (horizontalSizeClass == .compact) ? length * 0.46 : length * 0.48
                        } else {
                            return (horizontalSizeClass == .compact) ? length * 0.25 : length * 0.125
                        }
                    }
                }
                .background(selection == fraction ? Color.white : Color.gray)
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .padding(.horizontal, horizontalSizeClass == . compact ? 1 : 4)
                .scaleEffect(selection == fraction ? 1.05 : 1)
                .animation(.easeInOut(duration: 0.2), value: selection == fraction)
            }
        }
    }
}

#Preview {
    PickerWithImage(selection: .constant(.whole))
}
