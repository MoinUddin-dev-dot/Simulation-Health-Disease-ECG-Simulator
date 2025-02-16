//
//  MultiLineChartView.swift
//

import SwiftUI
import Charts

struct TimeData: Identifiable, Equatable {
    let patientId: Int
    let metric: String
    let value: Int
    
    var id: UUID = UUID()
}

struct MultiLineChartView: View {
    let patientIds: [Int]
    let startTimes: [Int]
    let endTimes: [Int]
    let waitingTimes: [Int]
    let turnaroundTimes: [Int]
    let responseTimes: [Int]
    let interArrivals : [Int]
    
    // Function to convert arrays to chart data
    func generateChartData() -> [(type: String, data: [TimeData])] {
        let metrics: [(String, [Int])] = [
            ("Start Time", startTimes),
            ("End Time", endTimes),
            ("Waiting Time", waitingTimes),
            ("Turnaround Time", turnaroundTimes),
            ("Response Time", responseTimes),
            ("InterArrival Time", interArrivals)
        ]
        
        return metrics.map { metric in
            (
                type: metric.0,
                data: zip(patientIds, metric.1).map { TimeData(patientId: $0.0, metric: metric.0, value: $0.1) }
            )
        }
    }
    
    var body: some View {
        let chartData = generateChartData()
        let interArrivalData = chartData.first { $0.type == "InterArrival Time" } // Filtered data
        
        Chart(chartData, id: \.type) { dataSeries in
            ForEach(dataSeries.data) { data in
                LineMark(
                    x: .value("Patient ID", data.patientId),
                    y: .value("Time", data.value)
                )
            }
            .foregroundStyle(by: .value("Metric", dataSeries.type))
            .symbol(by: .value("Metric", dataSeries.type))
        }
        .chartXAxisLabel("Patient IDs")
        .chartYAxisLabel("Time Values")
        .aspectRatio(1, contentMode: .fit)
        .padding()
        
        // Bar Chart for "InterArrival Time"
        if let interArrivalData {
            Chart(interArrivalData.data) { data in
                BarMark(
                    x: .value("Patient ID", data.patientId),
                    y: .value("Time", data.value)
                )
                .foregroundStyle(.mint)
                .symbol(by: .value("Metric", interArrivalData.type))// Use a single color or predefined style
            }
            .chartXAxisLabel("Patient IDs")
            .chartYAxisLabel("Time Values")
            .aspectRatio(1, contentMode: .fit)
            .padding()
        }

    }
}

#Preview {
    MultiLineChartView(
        patientIds: [1, 2, 3, 4, 5],
        startTimes: [10, 20, 30, 40, 25],
        endTimes: [15, 25, 35, 45, 60],
        waitingTimes: [5, 5, 5, 5, 5],
        turnaroundTimes: [8, 8, 8, 8, 8],
        responseTimes: [3, 3, 3, 3, 3],
        interArrivals : [3, 3, 3, 3, 3]
    )
}
