//
//  GeneratedView.swift
//  sim2
//
//  Created by Moin on 1/4/25.
//

import SwiftUI

struct GeneratedView: View {
    var arrivalMean: Double
        var serviceMean: Double
        var numberOfServers: Int
        
        @State private var utilization: Double = 0.0
        @State private var avgSystemLength: Double = 0.0
        @State private var avgQueueLength: Double = 0.0
        @State private var avgWaitTimeInSystem: Double = 0.0
        @State private var avgWaitTimeInQueue: Double = 0.0
        
        var body: some View {
            ZStack {
                // Fancy Gradient Background with subtle animations
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue, Color.purple, Color.pink, Color.orange]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                .opacity(0.8) // Subtle opacity to let content pop
                ScrollView{
                    VStack(alignment: .center, spacing: 20) {
                        Text("M/M/N Simulation Results")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                        
                        VStack(alignment: .leading, spacing: 20) {
                            // Utilization
                            Text("Utilization (ρ): \(String(format: "%.2f", utilization))")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue.opacity(0.7))
                                .cornerRadius(10)
                                .shadow(radius: 5)
                            
                            // Average System Length
                            Text("Average System Length (L): \(String(format: "%.2f", avgSystemLength))")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.green.opacity(0.7))
                                .cornerRadius(10)
                                .shadow(radius: 5)
                            
                            // Average Queue Length
                            Text("Average Queue Length (Lq): \(String(format: "%.2f", avgQueueLength))")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.purple.opacity(0.7))
                                .cornerRadius(10)
                                .shadow(radius: 5)
                            
                            // Average Wait Time in System
                            Text("Average Wait Time in System (W): \(String(format: "%.2f", avgWaitTimeInSystem))")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.orange.opacity(0.7))
                                .cornerRadius(10)
                                .shadow(radius: 5)
                            
                            // Average Wait Time in Queue
                            Text("Average Wait Time in Queue (Wq): \(String(format: "%.2f", avgWaitTimeInQueue))")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.red.opacity(0.7))
                                .cornerRadius(10)
                                .shadow(radius: 5)
                        }
                        .padding()
                        
                        Spacer()
                    }
                }
            }
            .onAppear {
                // Calculate using the formulas
                calculateMMNMetrics()
            }
        }
        
    func calculateMMNMetrics() {
        let lambda = arrivalMean // Arrival rate
        let mu = serviceMean     // Service rate
        let N = Double(numberOfServers) // Number of servers

        // Step 1: Utilization (ρ)
        utilization = lambda / (N * mu)
        
        if utilization >= 1.0 {
            // System is unstable if utilization >= 1
            print("System is unstable. Utilization must be less than 1.")
            return
        }

        // Step 2: Calculate P0 (Probability of zero customers in the system)
        var sum = 0.0
        for k in 0..<Int(N) {
            sum += pow(lambda / mu, Double(k)) / factorial(k)
        }
        let lastTerm = pow(lambda / mu, N) / (factorial(Int(N)) * (1 - utilization))
        let P0 = 1 / (sum + lastTerm)
        
        // Step 3: Average Queue Length (Lq)
        let numerator = P0 * pow(lambda / mu, N) * utilization
        let denominator = factorial(Int(N)) * pow(1 - utilization, 2)
        avgQueueLength = numerator / denominator

        // Step 4: Average System Length (L)
        avgSystemLength = avgQueueLength + (lambda / mu)

        // Step 5: Average Wait Time in Queue (Wq)
        avgWaitTimeInQueue = avgQueueLength / lambda

        // Step 6: Average Wait Time in System (W)
        avgWaitTimeInSystem = avgSystemLength / lambda
    }

    // Helper function for factorial
    func factorial(_ n: Int) -> Double {
        return n == 0 ? 1 : Double((1...n).reduce(1, *))
    }

}

#Preview {
    GeneratedView(arrivalMean: 10, serviceMean: 10, numberOfServers: 2)
}
