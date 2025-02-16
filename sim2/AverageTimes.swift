//
//  AverageTimes.swift
//  sim2
//
//  Created by Moin on 1/6/25.
//

import SwiftUI

struct AverageTimes: View {
    
    let patientIds: [Int]
    let arrivalTimes: [Int]
    let startTimes: [Int]
    let serviceTimes: [Int]
    let endTimes: [Int]
    let waitingTimes: [Int]
    let turnaround: [Int]
    let responseTimes: [Int]
    let serverAssignments: [[Int]]
    let interArrivals: [Int]
    let utlization: [Double]
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.purple.opacity(0.8)]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    Text("Average Times Metrics")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.bottom, 10)
                    
                    // Metric Cards
                    metricCard(title: "Average Turnaround Time",
                               value: averageTurnaround(),
                               iconName: "clock")
                    
                    metricCard(title: "Average Waiting Time",
                               value: averagewaitingTimes(),
                               iconName: "hourglass")
                    
                    metricCard(title: "Average Response Time",
                               value: averageresponseTimes(),
                               iconName: "waveform.path.ecg")
                    
                    metricCard(title: "Average Service Time",
                               value: averageserviceTimes(),
                               iconName: "wrench.and.screwdriver")
                    
                    metricCard(title: "Average Arrival Time",
                               value: averagearrivalTimes(),
                               iconName: "airplane.arrival")
                    
                    metricCard(title: "Queue Length-Customer Who Wait",
                               value: Double(countNonZeroElements(in: waitingTimes)),
                               iconName: "person.2")
                    
                    metricCard(title: "Servers Utilization",
                               value: processFirstRow(from: serverAssignments),
                               iconName: "server.rack")
                    metricCard(title: "Average Inter Arrival Time",
                               value: averageinterArrival(),
                               iconName: "chart.bar")
                    printUtilization(utlization)
                    
                }
                .padding()
            }
        }
    }
    
    // Card Component
    func metricCard(title: String, value: Double, iconName: String) -> some View {
        HStack {
            Image(systemName: iconName)
                .font(.title)
                .foregroundColor(.white)
                .padding()
                .background(Circle().fill(Color.orange))
            
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text("\(value, specifier: "%.2f")")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.orange)
            }
            Spacer()
        }
        .padding()
        .background(Color.white.opacity(0.2))
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 5)
    }
    
    func averageTurnaround() -> Double {
        let total = turnaround.reduce(0, +)
        return Double(total) / Double(turnaround.count)
    }
    
    func printUtilization(_ utilization: [Double]) -> some View {
        VStack {
            ForEach(utilization.indices, id: \.self) { index in
                metricCard(title: "Server \(index + 1) Utilization: \(String(format: "%.2f%%", utilization[index]))",
                           value: utilization[index],
                           iconName: "server.rack")
            }
        }
    }
    
    func averageinterArrival() -> Double {
        let total = interArrivals.reduce(0, +)
        return Double(total) / Double(interArrivals.count)
    }
    
    func averagewaitingTimes() -> Double {
        let total = waitingTimes.reduce(0, +)
        return Double(total) / Double(waitingTimes.count)
    }
    
    func averageresponseTimes() -> Double {
        let total = responseTimes.reduce(0, +)
        return Double(total) / Double(responseTimes.count)
    }
    
    func averageserviceTimes() -> Double {
        let total = serviceTimes.reduce(0, +)
        return Double(total) / Double(serviceTimes.count)
    }
    
    func averagearrivalTimes() -> Double {
        let total = arrivalTimes.reduce(0, +)
        return Double(total) / Double(arrivalTimes.count)
    }
    
    
    func countNonZeroElements(in array: [Int]) -> Int {
        return array.filter { $0 != 0 }.count
    }
    
    func processFirstRow(from array: [[Int]]) -> Double {
        guard let firstRow = array.first else { return 0 }
        let elementCount = firstRow.count
        return Double(elementCount) / Double(patientIds.count)
    }
}

#Preview {
    AverageTimes(patientIds: [1, 2, 3, 4, 5],
                 arrivalTimes: [5, 15, 25, 35, 45],
                 startTimes: [10, 20, 30, 40, 25],
                 serviceTimes: [5, 5, 5, 5, 10],
                 endTimes: [15, 25, 35, 45, 60],
                 waitingTimes: [5, 5, 5, 5, 5],
                 turnaround: [8, 8, 8, 8, 8],
                 responseTimes: [3, 3, 3, 3, 3],
                 serverAssignments: [[1, 2, 3], [1, 2, 3, 4, 5]], interArrivals: [3, 3, 3, 3, 3], utlization: [3.2,4.5])
}
