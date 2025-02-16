import SwiftUI

struct ServerAssign1: View {
    let arrivals: [Int]
    let serviceTimes: [Int]
    let numberOfServers: Int
    let patientId: [Int]
    let priorities: [Int]
    let interArrivals: [Int]
    
    @State private var serverAssignments: [[Int]] = []
    @State private var startTimes: [Int] = []
    @State private var endTimes: [Int] = []
    @State private var patientEndTimes: [Int] = []
    @State private var waitingTimes: [Int] = []
    @State private var turnaroundTimes: [Int] = []
    @State private var responseTimes: [Int] = []
    
    @State private var showGanttChart = false
    @State private var showGraph = false
    @State private var showData = false

    
    var body: some View {
        VStack {
            Text("Patient Server Assignment")
                .font(.largeTitle)
                    .bold()
                    .padding()
                    .foregroundStyle(LinearGradient(
                        gradient: Gradient(colors: [Color.blue, Color.purple]),
                        startPoint: .leading,
                        endPoint: .trailing
                    ))
                    .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 5)

            NavigationLink(destination: Cocomo1()) {
                Text("Show Chi Sqaure Data")
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
            
            
            
            NavigationLink(destination: ContentView1(patientIds: patientId, arrivalTimes: arrivals, startTimes: startTimes, serviceTimes: serviceTimes, endTimes: patientEndTimes, waitingTimes: waitingTimes, turnaroundTimes: turnaroundTimes, responseTimes: responseTimes, priorities: priorities, numberOfServer: numberOfServers, server: serverAssignments, interArrivals: interArrivals)) {
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
            .padding()
            
            
//            
//            Button(action: {
//                showGanttChart.toggle()
//            }) {
//                Text("Show Gantt Chart")
//                    .font(.headline)
//                                .padding()
//                                .frame(maxWidth: .infinity)
//                                .background(LinearGradient(
//                                    gradient: Gradient(colors: [Color.blue, Color.purple]),
//                                    startPoint: .leading,
//                                    endPoint: .trailing
//                                ))
//                                .foregroundColor(.white)
//                                .cornerRadius(15)
//                                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
//            }
//            .padding()
//            
//            // Navigation to Gantt Chart View
//            if showGanttChart {
//                GanttChartView1(patientIds: patientId, startTimes: startTimes, endTimes: patientEndTimes, priorities: priorities, numberOfServers: numberOfServers)
//                    .transition(.slide)
//            }
//            
//            Button(action: {
//                showGraph.toggle()
//            }) {
//                Text("Show Graph Chart")
//                    .font(.headline)
//                                .padding()
//                                .frame(maxWidth: .infinity)
//                                .background(LinearGradient(
//                                    gradient: Gradient(colors: [Color.blue, Color.purple]),
//                                    startPoint: .leading,
//                                    endPoint: .trailing
//                                ))
//                                .foregroundColor(.white)
//                                .cornerRadius(15)
//                                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
//            }
//            .padding()
//            
//            // Navigation to Gantt Chart View
//            if showGraph {
//                MultiLineChartView(patientIds: patientId, startTimes: startTimes, endTimes: patientEndTimes, waitingTimes: waitingTimes, turnaroundTimes: turnaroundTimes, responseTimes: responseTimes, interArrivals: interArrivals)
//            }
//            
            

        }
        .onAppear {
            simulatePatientAssignment()
        }
    }
    
    func simulatePatientAssignment() {
        // Initialize servers and tracking variables
        serverAssignments = Array(repeating: [], count: numberOfServers)
        startTimes = Array(repeating: 0, count: arrivals.count)
        endTimes = Array(repeating: 0, count: numberOfServers)
        patientEndTimes = Array(repeating: 0, count: arrivals.count)
        waitingTimes = Array(repeating: 0, count: arrivals.count)
        turnaroundTimes = Array(repeating: 0, count: arrivals.count)
        responseTimes = Array(repeating: 0, count: arrivals.count)

        for i in 0..<arrivals.count {
            var assignedServer: Int?

            // Find the earliest free server
            for server in 0..<numberOfServers {
                if arrivals[i] >= endTimes[server] {
                    assignedServer = server
                    break
                }
            }

            // If no free server is found, wait for the earliest free one
            if assignedServer == nil {
                assignedServer = endTimes.firstIndex(of: endTimes.min()!)!
            }

            // Assign patient to the chosen server
            let server = assignedServer!
            serverAssignments[server].append(i + 1) // Store patient ID (1-based index)

            // Calculate the start time correctly:
            startTimes[i] = max(arrivals[i], endTimes[server])

            // Update the end time of the assigned server
            endTimes[server] = startTimes[i] + serviceTimes[i]

            // Calculate and store the patient's end time
            patientEndTimes[i] = endTimes[server]

            // Calculate Waiting Time
            waitingTimes[i] = startTimes[i] - arrivals[i]

            // Calculate Turnaround Time
            turnaroundTimes[i] = patientEndTimes[i] - arrivals[i]

            // Calculate Response Time
            responseTimes[i] = startTimes[i] - arrivals[i]
            
            
        }
        
    }
    
}




#Preview {
    ServerAssign1(
        arrivals: [0, 3, 4, 6, 13, 14, 18, 20, 22, 24],
        serviceTimes: [1, 3, 3, 10, 1, 5, 4, 18, 20, 5],
        numberOfServers: 2,
        patientId: [1,2,3,4,5,6,7,8,9,10], priorities: [1,2,3,4,5,6,7,8,9,10], interArrivals: [1, 3, 3, 10, 1, 5, 4, 18, 20, 5]
    )
}
