import SwiftUI

struct GeneratedView2: View {
    var arrivalMean: Double
    var minService: Double
    var maxService: Double
    var numberOfServers: Int

    // Computed properties for calculations
    var serviceMean: Double {
        (minService + maxService) / 2
    }

    var serviceVariance: Double {
        let mean = serviceMean
        return ((maxService - mean) * (maxService - mean) + (minService - mean) * (minService - mean)) / 2
    }

    var utilization: Double {
        arrivalMean / (Double(numberOfServers) * serviceMean)
    }

    var avgQueueLength: Double {
        let p = utilization
        let c2s = serviceVariance / (serviceMean * serviceMean) // Coefficient of variation squared
        let numerator = (p * p) * (1 + c2s)
        let denominator = 2 * (1 - p)
        return numerator / denominator
    }

    var avgSystemLength: Double {
        avgQueueLength + utilization
    }

    var avgWaitTimeInSystem: Double {
        avgSystemLength / arrivalMean
    }

    var avgWaitTimeInQueue: Double {
        avgQueueLength / arrivalMean
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
            VStack(alignment: .center, spacing: 20) {
                ScrollView {
                    Text("M/G/N Simulation Results")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.black.gradient)
                        .cornerRadius(10)
                    VStack(alignment: .leading, spacing: 15) {
                        ResultRow(title: "Utilization (ρ):", value: utilization)
                        ResultRow(title: "Average System Length (L):", value: avgSystemLength)
                        ResultRow(title: "Average Queue Length (Lq):", value: avgQueueLength)
                        ResultRow(title: "Average Wait Time in System (W):", value: avgWaitTimeInSystem)
                        ResultRow(title: "Average Wait Time in Queue (Wq):", value: avgWaitTimeInQueue)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(15)
                .shadow(radius: 5)
                
                Spacer()
            }
        }
        .navigationTitle("M/G/N Results")
    }
}

struct ResultRow: View {
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
        .background(RoundedRectangle(cornerRadius: 10).fill(LinearGradient(colors: [Color.mint , .white], startPoint: .leading, endPoint: .trailing)))
        .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    GeneratedView2(arrivalMean: 10, minService: 12, maxService: 14, numberOfServers: 4)
}
