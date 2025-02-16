//
//  QueuingModel.swift
//  sim2
//
//  Created by Moin on 1/4/25.
//

import SwiftUI

struct QueuingModelView: View {
    var body: some View {
        ZStack {
            // Background Gradient with Blur Effect
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.2, green: 0.4, blue: 0.7),
                    Color(red: 0.5, green: 0.3, blue: 0.8),
                    Color(red: 0.9, green: 0.6, blue: 0.4)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            .blur(radius: 15)
            
            VStack {
                Spacer()

                // Title Text with Glow Effect
                Text("Select Queueing Model")
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

                // Buttons with Fancy Style
                VStack(spacing: 30) {
                    NavigationLink(destination: MMNView()) {
                        FancyButton(text: "M/M/N", gradient: Gradient(colors: [Color.blue, Color.cyan]))
                    }

                    NavigationLink(destination: MGNView()) {
                        FancyButton(text: "M/G/N", gradient: Gradient(colors: [Color.green, Color.mint]))
                    }

                    NavigationLink(destination: GGNView()) {
                        FancyButton(text: "G/G/N", gradient: Gradient(colors: [Color.orange, Color.pink]))
                    }
                }
                .padding(.horizontal, 20)

                Spacer()
            }
            .padding()
            .navigationTitle("Queuing Model")
        }
    }
}



#Preview {
    QueuingModelView()
}
