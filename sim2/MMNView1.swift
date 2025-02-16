//
//  MMNView1.swift
//  sim2
//
//  Created by Moin on 1/5/25.
//

import SwiftUI

struct MMNView1: View {
    var body: some View {
        ZStack {
            // Background Gradient with Blur Effect
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.3, green: 0.6, blue: 0.9),
                    Color(red: 0.6, green: 0.3, blue: 0.8),
                    Color(red: 0.9, green: 0.5, blue: 0.4)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            .blur(radius: 15)

            VStack {
                Spacer()

                // Priority Label with Glow Effect
                Text("Priority")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.8), radius: 4, x: 2, y: 2)

                // Animated Divider Line
                Rectangle()
                    .frame(height: 3)
                    .foregroundColor(.white.opacity(0.5))
                    .padding(.horizontal, 50)
                    .shadow(color: .white.opacity(0.3), radius: 5)

                Spacer()

                // Buttons for Priority Options
                VStack(spacing: 30) {
                    NavigationLink(destination: PriorityYesView()) {
                        FancyButton(text: "Yes", gradient: Gradient(colors: [Color.green, Color.mint]))
                    }

                    NavigationLink(destination: PriorityNoView()) {
                        FancyButton(text: "No", gradient: Gradient(colors: [Color.red, Color.orange]))
                    }
                }
                .padding(.horizontal, 20)

                Spacer()
            }
            .padding()
            .navigationTitle("M/M/N Simulation")
        }
    }
}



#Preview {
    MMNView1()
}
