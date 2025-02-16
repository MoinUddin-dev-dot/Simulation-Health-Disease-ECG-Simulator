import SwiftUI

struct PatientDataView: View {
    let patientIds: [Int]
    let arrivalTimes: [Int]   // Added
    let startTimes: [Int]
    let serviceTimes: [Int]  // Added
    let endTimes: [Int]
    let waitingTimes: [Int]
    let turnaroundTimes: [Int]
    let responseTimes: [Int]
    let serverAssignments: [[Int]]
    let priorities : [Int]?
    let interArrivals: [Int]
    let numberOfServers : Int
    @State private var showGanttChart = false
    @State private var showGraph = false
    
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Patient Timings")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top)
                
                ForEach(0..<patientIds.count, id: \.self) { index in
                    PatientCardView(
                        patientId: patientIds[index],
                        arrivalTime: arrivalTimes[index],   // Pass arrival time
                        startTime: startTimes[index],
                        serviceTime: serviceTimes[index],   // Pass service time
                        endTime: endTimes[index],
                        waitingTime: waitingTimes[index],
                        turnaroundTime: turnaroundTimes[index],
                        responseTime: responseTimes[index],
                        priorities: priorities?[index] ?? 0,
                        interArrivals: interArrivals[index]
                    )
                }
                let totalSimulationTime = arrivalTimes.count
                let serverUtilizations = serverAssignments.map { serverArray in
                    (Double(serverArray.count) / Double(totalSimulationTime)) * 100
                }
                
                NavigationLink(destination: AverageTimes(patientIds: patientIds, arrivalTimes: arrivalTimes, startTimes: startTimes, serviceTimes: serviceTimes, endTimes: endTimes, waitingTimes: waitingTimes, turnaround: turnaroundTimes, responseTimes: responseTimes, serverAssignments: serverAssignments, interArrivals: interArrivals, utlization: serverUtilizations )) {
                    Text("Show Patient Data")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(LinearGradient(
                            gradient: Gradient(colors: [Color.blue, Color.purple]),
                            startPoint: .leading,
                            endPoint: .trailing
                        ))
                        .foregroundColor(.white)
                        .cornerRadius(15)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                }
                
                
                Button(action: {
                    showGanttChart.toggle()
                }) {
                    Text("Show Gantt Chart")
                        .font(.headline)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(LinearGradient(
                                        gradient: Gradient(colors: [Color.blue, Color.purple]),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    ))
                                    .foregroundColor(.white)
                                    .cornerRadius(15)
                                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                }
                .padding()
                
                // Navigation to Gantt Chart View
                if showGanttChart {
                    GanttChartView1(patientIds: patientIds, startTimes: startTimes, endTimes: endTimes , priorities: priorities, numberOfServers: numberOfServers)
                        .transition(.slide)
                }
                
                Button(action: {
                    showGraph.toggle()
                }) {
                    Text("Show Graph Chart")
                        .font(.headline)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(LinearGradient(
                                        gradient: Gradient(colors: [Color.blue, Color.purple]),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    ))
                                    .foregroundColor(.white)
                                    .cornerRadius(15)
                                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                }
                .padding()
                
                // Navigation to Gantt Chart View
                if showGraph {
                    MultiLineChartView(patientIds: patientIds, startTimes: startTimes, endTimes: endTimes, waitingTimes: waitingTimes, turnaroundTimes: turnaroundTimes, responseTimes: responseTimes, interArrivals: interArrivals)
                }
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
    }
}

struct PatientCardView: View {
    let patientId: Int
    let arrivalTime: Int      // Added
    let startTime: Int
    let serviceTime: Int      // Added
    let endTime: Int
    let waitingTime: Int
    let turnaroundTime: Int
    let responseTime: Int
    let priorities : Int
    let interArrivals : Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            HStack{
                Text("Patient ID: \(patientId)")
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
                Text("Priority : \(priorities)")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.trailing)
            }
            
            
            Divider()
                .background(Color.white.opacity(0.5))
            
            HStack {
                DataRow(title: "Arrival Time", value: "\(arrivalTime)")   // Show arrival time
                DataRow(title: "Start Time", value: "\(startTime)")
            }
            
            HStack {
                DataRow(title: "Service Time", value: "\(serviceTime)")  // Show service time
                DataRow(title: "End Time", value: "\(endTime)")
            }
            
            HStack {
                DataRow(title: "Waiting Time", value: "\(waitingTime)")
                DataRow(title: "Turnaround Time", value: "\(turnaroundTime)")
            }
            
            HStack {
                DataRow(title: "Response Time", value: "\(responseTime)")
                DataRow(title: "Inter Arrival Time", value: "\(interArrivals)")
            }
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.purple.opacity(0.8)]), startPoint: .top, endPoint: .bottom))
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
        
        
    }
}

struct DataRow: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.caption)
                .foregroundColor(.white.opacity(0.7))
            Text(value)
                .font(.subheadline)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    PatientDataView(
        patientIds: [1, 2, 3, 4, 5],
        arrivalTimes: [5, 15, 25, 35, 45],  // Example arrival times
        startTimes: [10, 20, 30, 40, 25],
        serviceTimes: [5, 5, 5, 5, 10],     // Example service times
        endTimes: [15, 25, 35, 45, 60],
        waitingTimes: [5, 5, 5, 5, 5],
        turnaroundTimes: [8, 8, 8, 8, 8],
        responseTimes: [3, 3, 3, 3, 3], serverAssignments: [[1,2,3,4,5]], priorities: [1,2,3,1,2], interArrivals: [5, 5, 5, 5, 5], numberOfServers: 3
    )
}
