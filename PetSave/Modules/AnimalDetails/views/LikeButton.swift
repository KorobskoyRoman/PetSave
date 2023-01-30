//
//  LikeButton.swift
//  PetSave
//
//  Created by Roman Korobskoy on 30.01.2023.
//

import SwiftUI

struct LikeButton: View {
    @Binding var isPressed: Bool
    @State var scale : CGFloat = 1
    @State var opacity  = 0.0

    var body: some View {
        ZStack {
            Image(systemName: "heart.fill")
                .foregroundColor(isPressed ? Color(.systemRed) : Color(.black))
                .opacity(isPressed ? 1 : 0)
                .scaleEffect(isPressed ? 1.0 : 0.1)
                .animation(.linear, value: $isPressed.wrappedValue)
            Image(systemName: "heart")
                .foregroundColor(isPressed ? Color(.systemRed) : Color(.black))

            CirclesView(radius: 35, speed: 0.1, scale: 0.7, isPressed: $isPressed)
                .opacity(self.opacity)

            CirclesView(radius: 55, speed: 0.2, scale: 0.5 , isPressed: $isPressed)
                .opacity(self.opacity)
                .rotationEffect(Angle(degrees: 20))
        }
        .font(.system(size: 40))
        .onTapGesture {
            self.isPressed.toggle()
            withAnimation (.linear(duration: 0.2)) {
                self.scale = self.scale == 1 ? 1.3 : 1
                self.opacity = self.opacity == 0 ? 1 : 0
            }
            withAnimation {
                self.opacity = self.opacity == 0 ? 1 : 0
            }
        }
        .scaleEffect(self.scale)
        .foregroundColor(isPressed ? .red : .white)
    }
}

struct CirclesView : View {
    let angle : CGFloat = 40
    let radius : CGFloat
    let speed : Double
    let scale : CGFloat
    @Binding var isPressed: Bool

    var body: some View {
        ZStack {
            ForEach (0..<99) { num in
                let xExp = self.angle * .pi / 180
                let xExp1 = self.radius * cos(CGFloat(num) * xExp)
                let yExp = self.angle * .pi / 180
                let yExp1 = self.radius * sin(CGFloat(num) * yExp)
                Circle()
                    .fill(Color.red)
                    .frame(width: 10)
                    .scaleEffect(self.isPressed ? 0.1 : self.scale)
                    .animation(.linear(duration: self.speed))
                    .offset(
                        x: xExp1,
                        y: yExp1
                    )
            }
        }
        .padding()
    }
}
