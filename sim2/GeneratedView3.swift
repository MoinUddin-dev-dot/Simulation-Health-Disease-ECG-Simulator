//
//  GeneratedView3.swift
//  sim2
//
//  Created by Moin on 1/4/25.
//

import SwiftUI

struct GeneratedView3: View {
    let arrivalMean: Double
        let serviceMean: Double
        let arrivalVariance: Double
        let serviceVariance: Double
        let numberOfServers: Int
        
    // Utilization calculation
        var utilization: Double {
            let rho = arrivalMean / (Double(numberOfServers) * serviceMean)
            return min(rho, 1.0) // Ensure utilization doesn't exceed 1.0
        }
        
    // Average Queue Length calculation (G/G/N model)
       var avgQueueLength: Double {
           if utilization >= 1.0 {
               return Double.infinity // System is unstable
           }
           let varianceFactor = (arrivalVariance + serviceVariance) / 2.0
           return (pow(utilization, 2) * (1 + varianceFactor)) / (1 - utilization)
       }
        
        // Average System Length calculation
        var avgSystemLength: Double {
            avgQueueLength + (arrivalMean / serviceMean)
        }
        
        // Average Wait Time in Queue calculation
        var avgWaitTimeInQueue: Double {
            avgQueueLength / arrivalMean
        }
        
        // Average Wait Time in System calculation
        var avgWaitTimeInSystem: Double {
            avgWaitTimeInQueue + (1 / serviceMean)
        }
        
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
                    Text("G/G/N Simulation Results")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.black.gradient)
                        .cornerRadius(10)
                    
                    
                    FancyMetricView(title: "Utilization (ρ)", value: utilization)
                    FancyMetricView(title: "Average System Length (L)", value: avgSystemLength)
                    FancyMetricView(title: "Average Queue Length (Lq)", value: avgQueueLength)
                    FancyMetricView(title: "Average Wait Time in System (W)", value: avgWaitTimeInSystem)
                    FancyMetricView(title: "Average Wait Time in Queue (Wq)", value: avgWaitTimeInQueue)
                    
                    Spacer()
                }
                .padding()
            }
        }
    }
}

struct FancyMetricView: View {
    let title: String
    let value: Double
    
    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
            Spacer()
            Text(String(format: "%.2f", value))
                .font(.body)
                .foregroundColor(value.isInfinite ? .red : .blue)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(LinearGradient(colors: [Color.clear , Color.white], startPoint: .leading, endPoint: .trailing)))
        .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    GeneratedView3(arrivalMean: 10, serviceMean: 12, arrivalVariance: 4, serviceVariance: 2, numberOfServers: 4)
}
