//
//  ContentView.swift
//  sim2
//
//  Created by Moin on 1/4/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                // Multi-Color Background Gradient
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color(red: 0.1, green: 0.1, blue: 0.5), // Deep Blue
                                        Color(red: 0.3, green: 0.1, blue: 0.7), // Purple
                                        Color(red: 0.8, green: 0.4, blue: 0.9), // Pink
                                        Color(red: 0.5, green: 0.8, blue: 0.8)  // Teal
                                    ]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                                .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    
                    // Title
                    Text("Heart Disease ECG Simulator")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.8), radius: 4, x: 2, y: 2)
                    // Subtitle
                    Text("Submitted to Dr. Shaista Rais")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.8), radius: 4, x: 2, y: 2)
                        .padding(.top)
                    
                    Spacer()
                    
                    // Buttons with fancy design
                    HStack(spacing: 20) {
                        NavigationLink(destination: SimulatorView()) {
                            Text("Simulator")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color.blue, Color.cyan]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .cornerRadius(15)
                                .shadow(color: .blue.opacity(0.5), radius: 5, x: 2, y: 2)
                        }
                        
                        NavigationLink(destination: QueuingModelView()) {
                            Text("Queuing Model")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color.green, Color.teal]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .cornerRadius(15)
                                .shadow(color: .green.opacity(0.5), radius: 5, x: 2, y: 2)
                        }
                    }
                    .padding(.top, 20)
                    
                    Spacer()
                }
                .padding()
            }
        }
    }
}

// Previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

