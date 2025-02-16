import SwiftUI

struct SimulatorView12: View {
    let arrivalMean: Double
    let serviceMean: Double
    let numberOfServers: Int

    
    var body: some View {
        let result = getArrivalTimes(meanArrivalNumber: arrivalMean)
        let cumulativeProbabilities = result["cumulativeProbabilities"] ?? []
        let probabilitiesString = cumulativeProbabilities.map { String($0) }.joined(separator: ", ")
        let cpLookUp = calculateCpLookUp(from: cumulativeProbabilities)
        let averageTimes = Array(0..<cumulativeProbabilities.count)
        let interArrivals = calculateInterArrivals(cumulativeProbabilities: cumulativeProbabilities)
        let arrivalTimes = calculateArrivalTimes(interArrivals: interArrivals)
        let serviceTimes = getServiceTimes(length: arrivalTimes.count, meanServiceNumber: 5.0)
        let patientIds = generatePatientIds(from: arrivalTimes.count)
        
        // Initialize Z value
        var Z = 10112166
        let priorities = getPriorities(length: arrivalTimes.count, A: 55, M: 1994, Z: &Z, C: 9, a: 1, b: 3)
        
        return ScrollView {
//            VStack {
//                Text("Cumulative Probabilities:")
//                    .font(.headline)
//                    .padding()
//                Text(probabilitiesString)
//                    .padding()
//                
//                Text("Cp LookUp:")
//                    .font(.headline)
//                    .padding()
//                Text(cpLookUp.map { String($0) }.joined(separator: ", "))
//                    .padding()
//                
//                Text("Average Times:")
//                    .font(.headline)
//                    .padding()
//                Text(averageTimes.map { String($0) }.joined(separator: ", "))
//                    .padding()
//                
//                Text("Inter Arrivals:")
//                    .font(.headline)
//                    .padding()
//                Text(interArrivals.map { String($0) }.joined(separator: ", "))
//                    .padding()
//                
//                Text("Arrival Times:")
//                    .font(.headline)
//                    .padding()
//                Text(arrivalTimes.map { String($0) }.joined(separator: ", "))
//                    .padding()
//                
//                Text("Service Times:")
//                    .font(.headline)
//                    .padding()
//                Text(serviceTimes.map { String($0) }.joined(separator: ", "))
//                    .padding()
//  
//                Text("Patient IDs: \(patientIds.map { String($0) }.joined(separator: ", "))")
//                
//                Text("Priorities: \(priorities.map { String($0) }.joined(separator: ", "))")
//                    .padding()
                
                VStack {
                    
                    ServerAssign(
                        arrivals: arrivalTimes,
                        serviceTimes: serviceTimes,
                        numberOfServers: numberOfServers,
                        patientId: patientIds, priorities: priorities,
                        interArrivals: interArrivals
                    )
                
                }
            }
        }
        
        
        
        func getArrivalTimes(meanArrivalNumber: Double) -> [String: [Double]] {
            var cumulativeProbability: Double = 0
            var cumulativeProbabilities: [Double] = []
            var x: Int = 0
            
            while roundToFourDecimals(value: cumulativeProbability) < 1 {
                let newValue = (exp(-meanArrivalNumber) * pow(meanArrivalNumber, Double(x))) / factorial(x)
                cumulativeProbability += newValue
                cumulativeProbabilities.append(roundToFourDecimals(value: cumulativeProbability))
                x += 1
            }
            
            return ["cumulativeProbabilities": cumulativeProbabilities]
        }
        
        func calculateCpLookUp(from cumulativeProbabilities: [Double]) -> [Double] {
            guard !cumulativeProbabilities.isEmpty else { return [] }
            var cpLookUp: [Double] = [0] // Start with 0
            for i in 0..<cumulativeProbabilities.count - 1 {
                cpLookUp.append(cumulativeProbabilities[i])
            }
            return cpLookUp
        }
        
        func calculateInterArrivals(cumulativeProbabilities: [Double]) -> [Int] {
            var interArrivals: [Int] = []
            for _ in 0..<cumulativeProbabilities.count {
                let randomNumber = Double.random(in: 0..<1)
                for (j, item) in cumulativeProbabilities.enumerated() {
                    if randomNumber < item {
                        interArrivals.append(j)
                        break
                    }
                }
            }
            return interArrivals
        }
        
        func calculateArrivalTimes(interArrivals: [Int]) -> [Int] {
            var arrivalTimes: [Int] = [interArrivals[0]]
            for i in 1..<interArrivals.count {
                arrivalTimes.append(arrivalTimes[i - 1] + interArrivals[i])
            }
            return arrivalTimes
        }
        
        func getServiceTimes(length: Int, meanServiceNumber: Double) -> [Int] {
            var serviceTimes: [Int] = []
            
            for _ in 0..<length {
                let serviceTime = -meanServiceNumber * log(Double.random(in: 0..<1))
                
                // Ensure service time is between 5 and 8 inclusive
                let clampedServiceTime = max(5, min(8, Int(ceil(serviceTime))))
                
                serviceTimes.append(clampedServiceTime)
            }
            
            return serviceTimes
        }
        
        
        func getPriorities(length: Int, A: Int, M: Int, Z: inout Int, C: Int, a: Int, b: Int) -> [Int] {
            var priorities: [Int] = []
            
            for _ in 0..<length {
                let R = (A * Z + C) % M
                let S = Double(R) / Double(M)
                let Y = Int(round((Double(b - a) * S + Double(a))))
                priorities.append(Y)
                Z = R // Update Z for the next iteration
            }
            
            return priorities
        }
        
        func generatePatientIds(from count: Int) -> [Int] {
            // Generate patient IDs from 1 to arrivalTimes.count
            return Array(1...count)
        }
        
        func roundToFourDecimals(value: Double) -> Double {
            return round(value * 10000) / 10000
        }
        
        func factorial(_ n: Int) -> Double {
            return n == 0 ? 1 : Double(n) * factorial(n - 1)
        }
    }
    
//}
    
#Preview {
        SimulatorView12(arrivalMean: 10, serviceMean: 5, numberOfServers: 2)
}
    
