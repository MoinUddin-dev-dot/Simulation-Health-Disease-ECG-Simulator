//
//  PriorityYes2.swift
//  sim2
//
//  Created by Moin on 1/5/25.
//

import SwiftUI

struct PriorityYes2: View {
    @State private var arrivalMean: String = ""
    @State private var serviceMean: String = ""
    @State private var numberOfServers: String = ""
    @State private var showSimulationView = false
    @State private var showError = false

    var body: some View {
        ZStack {
            // Fancy Gradient Background with Blur Effect
            LinearGradient(
                gradient: Gradient(colors: [Color.orange, Color.pink, Color.red]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            .blur(radius: 15)

            VStack(spacing: 30) {
                Spacer()

                // Title with Glow Effect
                Text("G/G/N with Priority")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.8), radius: 4, x: 2, y: 2)

                Spacer()

                // Input Fields with Cards
                VStack(spacing: 20) {
                    FancyInputField(label: "Arrival Mean", placeholder: "Enter decimal value", text: $arrivalMean, keyboardType: .decimalPad)
                    FancyInputField(label: "Service Mean", placeholder: "Enter decimal value", text: $serviceMean, keyboardType: .decimalPad)
                    FancyInputField(label: "Number of Servers", placeholder: "Enter whole number", text: $numberOfServers, keyboardType: .numberPad)
                }

                // Simulate Button
                Button(action: {
                    if let arrival = Double(arrivalMean),
                       let service = Double(serviceMean),
                       let servers = Int(numberOfServers),
                       arrival > 0, service > 0, servers > 0 {
                        showError = false
                        showSimulationView = true
                    } else {
                        showError = true
                    }
                }) {
                    Text("Simulate")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.green, Color.yellow]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(15)
                        .shadow(color: .black.opacity(0.3), radius: 10, x: 5, y: 5)
                }
                .alert(isPresented: $showError) {
                    Alert(title: Text("Invalid Input"),
                          message: Text("Ensure all fields are filled with valid values."),
                          dismissButton: .default(Text("OK")))
                }
                .background(
                    NavigationLink(
                        destination: SimulatorView13(
                            arrivalMean: Double(arrivalMean) ?? 0.0,
                            serviceMean: Double(serviceMean) ?? 0.0,
                            numberOfServers: Int(numberOfServers) ?? 0
                        ),
                        isActive: $showSimulationView,
                        label: { EmptyView() }
                    )
                    .hidden()
                )

                Spacer()
            }
            .padding()
            .navigationTitle("Priority Simulation")
        }
    }
}



#Preview {
    PriorityYes2()
}
