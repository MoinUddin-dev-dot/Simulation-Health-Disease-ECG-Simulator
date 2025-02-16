//
//  delete3.swift
//  sim2
//
//  Created by Moin on 1/6/25.
//

import SwiftUI

struct Cocomo1: View {
    
    @State private var chiSqaureSum: Double = 0
    @State private var arrivals: [Double] = []
    @State private var services: [Double] = []
    @State private var mle: [Double] = []
    @State private var expectedFrequency: [Double] = [] // For storing expected frequency values
    @State private var chiSquare: [Double] = [] // For storing chi-square values
    @State private var pmf: [Double] = [] // For storing PMF values
    @State private var errorMessage: String? = nil
    @State private var lambda: Double = 0.0 // For storing lambda value
    @State private var poissonMessage: String? = nil // For displaying Poisson message
    
    var body: some View {
        NavigationStack{
            VStack {
                // Error Message (if any)
//                if let errorMessage = errorMessage {
//                    Text("Error: \(errorMessage)")
//                        .foregroundColor(.red)
//                        .padding()
//                }
                
                // Display the data in a list
//                List(0..<arrivals.count, id: \.self) { index in
//                    HStack {
//                        //                    Text("Arrival: \(arrivals[index], specifier: "%.2f")")
//                        //                    Spacer()
//                        //                    Text("Service: \(services[index], specifier: "%.2f")")
//                        //                    Spacer()
//                        //                    Text("MLE: \(mle[index], specifier: "%.2f")")
//                        //                    Spacer()
//                        //                    Text("PMF: \(pmf[index], specifier: "%.4f")")
//                        //                    Spacer()
//                        //                    Text("Expected Frequency: \(expectedFrequency[index], specifier: "%.2f")")
//                        //                    Spacer()
//                        //                    Text("Chi-Square: \(chiSquare[index], specifier: "%.4f")")
//
//
//                    }
//                }
                
                Chisqaure(arrival: arrivals, service: services, mle: mle, expectedFrequency: expectedFrequency, chiSquare: chiSquare, pmf: pmf, poissonMessage: poissonMessage, chiSqaureSum: chiSqaureSum )
                
//                NavigationLink(destination: ) {
//                    Text("Go to New View")
//                        .font(.title)
//                        .padding()
//                        .background(Color.blue)
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//                }
//                .padding()
                
                // Display Poisson distribution message if chi-square sum is less than 5.991
//                if let poissonMessage = poissonMessage {
//                    Text(poissonMessage)
//                        .foregroundColor(.green)
//                        .padding()
//                }
//
//                Text("Chi-Square Sum: \(chiSqaureSum, specifier: "%.4f")")
//                    .padding()
                    .onAppear {
                        if let (arrivalsData, servicesData) = readCSVFile(fileName: "datarock") {
                            arrivals = arrivalsData
                            services = servicesData
                            // Calculate MLE after loading the data
                            mle = calculateMLE(arrivals: arrivals, services: services)
                            
                            // Calculate Lambda and PMF
                            lambda = calculateLambda(mle: mle, services: services)
                            pmf = calculatePMF(arrivals: arrivals, lambda: lambda)
                            // Calculate Expected Frequency
                            expectedFrequency = calculateExpectedFrequency(services: services, pmf: pmf)
                            // Calculate Chi-Square
                            chiSquare = calculateChiSquare(services: services, expectedFrequency: expectedFrequency)
                            chiSqaureSum = calculateChiSquareSum(chiSquare: chiSquare)
                            
                            // Check chi-square sum and display message accordingly
                            checkPoissonDistribution(chiSqaureSum: chiSqaureSum)
                        } else {
                            errorMessage = "Failed to parse the CSV file."
                        }
                    }
            }
            .padding()
        }
    }
    
    // Function to check chi-square sum and display Poisson distribution message if applicable
    func checkPoissonDistribution(chiSqaureSum: Double) {
        if chiSqaureSum < 67.50 {
            poissonMessage = "Poisson distribution ko follow karta hai hamara data."
        } else {
            poissonMessage = "Poisson distribution ko follow nhi karta hai hamara data." // Clear message if condition is not met
        }
    }
    
    // Function to calculate Chi-Square values with zero check
    func calculateChiSquare(services: [Double], expectedFrequency: [Double]) -> [Double] {
        var chiSquare: [Double] = []
        
        // Ensure both arrays have the same number of elements
        guard services.count == expectedFrequency.count else {
            print("Error: Arrays are of different lengths.")
            return chiSquare
        }
        
        // Apply the chi-square formula for each pair of service and expected frequency
        for i in 0..<services.count {
            let service = services[i]
            let expectedFreq = expectedFrequency[i]
            
            // Avoid division by zero by checking expected frequency
            if expectedFreq != 0 {
                // Calculate chi-square for each pair
                let chiSquareValue = pow(service - expectedFreq, 2) / expectedFreq
                chiSquare.append(chiSquareValue)
            } else {
                // If expected frequency is zero, set chi-square value to a large number or 0 based on your logic
                chiSquare.append(0) // or use a fallback value like `Double.infinity`
                print("Warning: Expected frequency is zero at index \(i), setting chi-square to 0.")
            }
        }
        
        return chiSquare
    }
    
    func calculateChiSquareSum(chiSquare: [Double]) -> Double {
        let sum = chiSquare.reduce(0, +) // Sum of all elements in the chi-square array
        return sum
    }
    
    // Function to calculate MLE by multiplying each arrival with the corresponding service
    func calculateMLE(arrivals: [Double], services: [Double]) -> [Double] {
        var mle: [Double] = []
        
        // Make sure both arrays are of the same length
        guard arrivals.count == services.count else {
            print("Error: Arrays are of different lengths.")
            return mle
        }
        
        // Multiply each arrival with the corresponding service
        for i in 0..<arrivals.count {
            let result = arrivals[i] * services[i]
            mle.append(result)
        }
        
        return mle
    }
    
    // Function to calculate Lambda
    func calculateLambda(mle: [Double], services: [Double]) -> Double {
        let sumMLE = mle.reduce(0, +)
        let sumService = services.reduce(0, +)
        
        // Calculate Lambda: sum of MLE array / sum of service array
        let lambda = sumMLE / sumService
        return lambda
    }
    
    // Function to calculate PMF (Probability Mass Function)
    func calculatePMF(arrivals: [Double], lambda: Double) -> [Double] {
        var pmf: [Double] = []
        
        // Calculate PMF using the formula
        for arrival in arrivals {
            let x = Int(arrival) // Convert arrival value to integer for factorial
            if let factorial = calculateFactorial(x: x) {
                // PMF formula: (exp(-lambda) * lambda^x) / x!
                let pmfValue = (exp(-lambda) * pow(lambda, Double(x))) / Double(factorial)
                pmf.append(pmfValue)
            } else {
                // Handle case where factorial calculation failed
                pmf.append(0.0)
            }
        }
        
        return pmf
    }
    
    // Function to calculate Factorial with overflow check
    func calculateFactorial(x: Int) -> UInt64? {
        if x == 0 || x == 1 {
            return 1
        }
        
        var result: UInt64 = 1
        
        for i in 2...x {
            // Check for overflow before multiplying
            if result > UInt64.max / UInt64(i) {
                print("Overflow detected for factorial of \(x).")
                return nil // Return nil in case of overflow
            }
            result *= UInt64(i)
        }
        
        return result
    }
    
    // Function to calculate Expected Frequency
    func calculateExpectedFrequency(services: [Double], pmf: [Double]) -> [Double] {
        var expectedFrequency: [Double] = []
        
        // Calculate the sum of the service array
        let sumService = services.reduce(0, +)
        
        // Now, multiply the sum of service array by each PMF element
        for pmfValue in pmf {
            let freq = sumService * pmfValue
            expectedFrequency.append(freq)
        }
        
        return expectedFrequency
    }
    
    // Function to read a CSV file and parse data into arrays
    func readCSVFile(fileName: String) -> ([Double], [Double])? {
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: "csv") else {
            print("File not found")
            return nil
        }
        
        do {
            let fileContents = try String(contentsOfFile: filePath)
            print("File Contents: \(fileContents)") // Debugging line to print the file contents
            
            let rows = fileContents.split(whereSeparator: { $0.isNewline || $0.isWhitespace })
            
            var arrivals: [Double] = []
            var services: [Double] = []
            
            for row in rows.dropFirst() {
                let cleanedRow = row.trimmingCharacters(in: .whitespacesAndNewlines)
                let columns = cleanedRow.split(separator: ",")
                
                if columns.count == 2, let arrival = Double(columns[0]), let service = Double(columns[1]) {
                    arrivals.append(arrival)
                    services.append(service)
                } else {
                    print("Invalid data in row: \(cleanedRow)")
                }
            }
            
            return (arrivals, services)
        } catch {
            print("Error reading the file: \(error.localizedDescription)")
            return nil
        }
    }
}
