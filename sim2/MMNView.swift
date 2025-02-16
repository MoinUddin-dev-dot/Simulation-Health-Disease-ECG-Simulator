import SwiftUI

struct MMNView: View {
    @State private var arrivalMean: Double? = nil
    @State private var serviceMean: Double? = nil
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
                Text("M/M/N Model")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.8), radius: 4, x: 2, y: 2)

                Spacer()
                
                // Input Fields with Fancy Card Style
                VStack(spacing: 20) {
                    FancyInputFieldDouble(label: "Arrival Mean", placeholder: "Enter Arrival Mean", value: $arrivalMean)
                    FancyInputFieldDouble(label: "Service Mean", placeholder: "Enter Service Mean", value: $serviceMean)
                    FancyInputFieldInt(label: "Number Of Servers", placeholder: "Enter Number Of Servers", value: $numberOfServers)
                }
                .padding(.horizontal, 20)
                
                // Generate Button with Gradient as a NavigationLink
                                NavigationLink(
                                    destination: GeneratedView(
                                        arrivalMean: arrivalMean ?? 0.0,
                                        serviceMean: serviceMean ?? 0.0,
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
            .navigationBarTitle("M/M/N Model", displayMode: .inline)
        }
    }
}

// Fancy Input Field for Double Type
struct FancyInputFieldDouble: View {
    let label: String
    let placeholder: String
    @Binding var value: Double?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(label)
                .font(.headline)
                .foregroundColor(.white)
            
            TextField(placeholder, value: $value, format: .number)
                .keyboardType(.decimalPad)
                .padding()
                .background(Color.white.opacity(0.3))
                .cornerRadius(10)
                .foregroundColor(.white)
                .shadow(color: .white.opacity(0.3), radius: 8, x: 0, y: 4)
        }
    }
}

// Fancy Input Field for Int Type
struct FancyInputFieldInt: View {
    let label: String
    let placeholder: String
    @Binding var value: Int?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(label)
                .font(.headline)
                .foregroundColor(.white)
            
            TextField(placeholder, value: $value, format: .number)
                .keyboardType(.numberPad)
                .padding()
                .background(Color.white.opacity(0.3))
                .cornerRadius(10)
                .foregroundColor(.white)
                .shadow(color: .white.opacity(0.3), radius: 8, x: 0, y: 4)
        }
    }
}

#Preview {
    MMNView()
}
