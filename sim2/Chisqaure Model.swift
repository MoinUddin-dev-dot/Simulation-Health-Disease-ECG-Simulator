import SwiftUI

struct Chisqaure: View {
    
    let arrival : [Double]
    let service : [Double]
    let mle: [Double]
    let expectedFrequency: [Double]
    let chiSquare: [Double]
    let pmf: [Double]
    let poissonMessage: String?
    let chiSqaureSum: Double
    
    var body: some View {
        VStack {
            ScrollView {
                // Display the data in a list of cards
                ForEach(0..<arrival.count, id: \.self) { index in
                    VStack {
                        HStack {
                            Text("Arrival: \(arrival[index], specifier: "%.2f")")
                                .font(.title2)
                                .fontWeight(.bold)
                            Spacer()
                            Text("Service: \(service[index], specifier: "%.2f")")
                                .font(.title2)
                                .foregroundColor(.blue)
                        }
                        .padding()
                        
                        HStack {
                            Text("MLE: \(mle[index], specifier: "%.2f")")
                            Spacer()
                            Text("Expected Freq: \(expectedFrequency[index], specifier: "%.2f")")
                        }
                        .padding(.horizontal)
                        
                        HStack {
                            Text("Chi-Square: \(chiSquare[index], specifier: "%.2f")")
                            Spacer()
                            Text("PMF: \(pmf[index], specifier: "%.2f")")
                        }
                        .padding(.horizontal)
                        
                        if let message = poissonMessage {
                            Text(message)
                                .padding(10)
                                .background(Color.green.opacity(0.3))
                                .cornerRadius(8)
                                .font(.body)
                                .foregroundColor(.green)
                        }
                        
                        Divider()
                            .padding(.vertical, 5)
                    }
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
                    .padding(.horizontal)
                }
            }
            
            // Chi-Square Sum Display
            Text("Chi-Square Sum: \(chiSqaureSum, specifier: "%.4f")")
                .font(.headline)
                .fontWeight(.bold)
                .padding()
                .background(Color.blue.opacity(0.2))
                .cornerRadius(10)
                .padding(.top, 20)
        }
        .navigationTitle("Chi-Square Data")
        .background(Color.white)
    }
}

#Preview {
    Chisqaure(
        arrival: [1, 2, 3, 4],
        service: [1, 2, 3, 4],
        mle: [1, 2, 3, 4],
        expectedFrequency: [1, 2, 3, 4],
        chiSquare: [1, 2, 3, 4],
        pmf: [1, 2, 3, 4],
        poissonMessage: "Poisson Distribution followed",
        chiSqaureSum: 4.9
    )
}
