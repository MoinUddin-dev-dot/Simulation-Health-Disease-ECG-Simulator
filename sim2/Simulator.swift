//
//  Simulator.swift
//  sim2
//
//  Created by Moin on 1/4/25.
//

import SwiftUI

struct SimulatorView: View {
    var body: some View {
        ZStack {
            // Background Gradient with Blur Effect
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.1, green: 0.3, blue: 0.6),
                    Color(red: 0.4, green: 0.2, blue: 0.7),
                    Color(red: 0.8, green: 0.4, blue: 0.3)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            .blur(radius: 20)
            
            VStack(alignment: .center) {
                Spacer()

                // Title Text with a Shadow Glow Effect
                Text("Select Simulation Model")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.8), radius: 4, x: 2, y: 2)

                // Animated Divider Line
                Rectangle()
                    .frame(height: 3)
                    .foregroundColor(.white.opacity(0.6))
                    .padding(.horizontal, 50)
                    .shadow(color: .white.opacity(0.3), radius: 5)

                Spacer()

                // Buttons with 3D Effects and Animations
                VStack(spacing: 30) {
                    NavigationLink(destination: MMNView1()) {
                        FancyButton(text: "M/M/N", gradient: Gradient(colors: [Color.blue, Color.cyan]))
                    }

                    NavigationLink(destination: MGNView1()) {
                        FancyButton(text: "M/G/N", gradient: Gradient(colors: [Color.green, Color.mint]))
                    }

                    NavigationLink(destination: GGNView1()) {
                        FancyButton(text: "G/G/N", gradient: Gradient(colors: [Color.red, Color.orange]))
                    }
                }
                .padding(.horizontal, 20)

                Spacer()
            }
            .padding()
            .navigationTitle("Simulator")
        }
    }
}

struct FancyButton: View {
    let text: String
    let gradient: Gradient

    var body: some View {
        Text(text)
            .font(.headline)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                LinearGradient(gradient: gradient, startPoint: .leading, endPoint: .trailing)
            )
            .cornerRadius(15)
            .shadow(color: .black.opacity(0.2), radius: 10, x: 5, y: 5)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(LinearGradient(gradient: gradient, startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 2)
            )
            .scaleEffect(1)
            .animation(.spring(response: 0.4, dampingFraction: 0.5, blendDuration: 0.4), value: 1)
    }
}

#Preview {
    SimulatorView()
}
