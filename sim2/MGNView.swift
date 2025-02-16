import SwiftUI

struct MGNView: View {
    @State private var arrivalMean: Double? = nil
    @State private var minimumService: Double? = nil
    @State private var maximumService: Double? = nil
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
                Text("M/G/N Model")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.8), radius: 4, x: 2, y: 2)

                Spacer()
                
                // Input Fields with Fancy Card Style
                VStack(spacing: 20) {
                    FancyInputFieldDouble(label: "Arrival Mean", placeholder: "Enter Arrival Mean", value: $arrivalMean)
                    FancyInputFieldDouble(label: "Minimum Service", placeholder: "Enter Minimum Service", value: $minimumService)
                    FancyInputFieldDouble(label: "Maximum Service", placeholder: "Enter Maximum Service", value: $maximumService)
                    FancyInputFieldInt(label: "Number Of Servers", placeholder: "Enter Number Of Servers", value: $numberOfServers)
                }
                .padding(.horizontal, 20)
                
                // Generate Button with Gradient as a NavigationLink
                                NavigationLink(destination: GeneratedView2(arrivalMean: arrivalMean ?? 0.0, minService: minimumService ?? 0.0, maxService: maximumService ?? 0.0, numberOfServers: numberOfServers ?? 0)
                                    )
                                 {
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
            .navigationBarTitle("M/G/N Model", displayMode: .inline)
        }
    }
}


#Preview {
    MGNView()
}
