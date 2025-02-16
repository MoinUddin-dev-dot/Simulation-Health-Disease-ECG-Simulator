//
//  GGNView1.swift
//  sim2
//
//  Created by Moin on 1/5/25.
//

import SwiftUI

struct GGNView1: View {
    var body: some View {
        ZStack {
            // Background Gradient with Blur Effect
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.9, green: 0.3, blue: 0.5),
                    Color(red: 0.3, green: 0.5, blue: 0.9),
                    Color(red: 0.4, green: 0.9, blue: 0.7)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
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
                    NavigationLink(destination: PriorityYes2()) {
                        FancyButton(text: "Yes", gradient: Gradient(colors: [Color.green, Color.teal]))
                    }

                    NavigationLink(destination: PriorityNo2()) {
                        FancyButton(text: "No", gradient: Gradient(colors: [Color.red, Color.purple]))
                    }
                }
                .padding(.horizontal, 20)

                Spacer()
            }
            .padding()
            .navigationTitle("G/G/N Simulation")
        }
    }
}



#Preview {
    GGNView1()
}
