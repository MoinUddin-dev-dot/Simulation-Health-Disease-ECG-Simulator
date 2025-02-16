import SwiftUI

struct GGNView: View {
    @State private var arrivalMean: Double? = nil
    @State private var serviceMean: Double? = nil
    @State private var arrivalVariance: Double? = nil
    @State private var serviceVariance: Double? = nil
    @State private var numberOfServers: Int? = nil
    @State private var showGeneratedView = false
    
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
            
            VStack(spacing: 30) {
                Spacer()
                
                // Title with Glow Effect
                Text("G/G/N Model")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .shadow(color: .white.opacity(0.7), radius: 10, x: 0, y: 0)
                
                Spacer()
                
                // Input Fields with Fancy Card Style
                VStack(spacing: 20) {
                    FancyInputFieldDouble(label: "Arrival Mean", placeholder: "Enter Arrival Mean", value: $arrivalMean)
                    FancyInputFieldDouble(label: "Service Mean", placeholder: "Enter Service Mean", value: $serviceMean)
                    FancyInputFieldDouble(label: "Arrival Variance", placeholder: "Enter Arrival Variance", value: $arrivalVariance)
                    FancyInputFieldDouble(label: "Service Variance", placeholder: "Enter Service Variance", value: $serviceVariance)
                    FancyInputFieldInt(label: "Number Of Servers", placeholder: "Enter Number Of Servers", value: $numberOfServers)
                }
                .padding(.horizontal, 20)
                
                // Generate Button with Gradient as a NavigationLink
                                NavigationLink(
                                    destination: GeneratedView3(
                                        arrivalMean: arrivalMean ?? 0.0,
                                        serviceMean: serviceMean ?? 0.0,
                                        arrivalVariance: arrivalVariance ?? 0.0,
                                        serviceVariance: serviceVariance ?? 0.0,
                                        numberOfServers: numberOfServers ?? 0
                                    )
                                ) {
                                    Text("Generate")
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
                                        .shadow(color: .black.opacity(0.2), radius: 10, x: 5, y: 5)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal, 20)
                                
                                Spacer()
                
                
            }
            .padding()
            .navigationBarTitle("G/G/N Model", displayMode: .inline)
        }
    }
}


#Preview {
    GGNView()
}
