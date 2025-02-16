import SwiftUI

struct GanttChartView12: View {
    let servers: Int
    let serverPatients: [[Task]]  // Each server will have an array of tasks
    @State private var showGanttChart = false

    struct Task: Identifiable {
        let id = UUID()
        let patientId: Int
        let startTime: Int
        let endTime: Int
        let priority: Int
    }

    var body: some View {
        VStack {
            ForEach(0..<servers, id: \.self) { serverIndex in
                VStack {
                    Text("Server \(serverIndex + 1) Task Gantt Chart")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()

                    ScrollView(.horizontal) {
                        HStack(spacing: 10) {
                            // Display each patient's task details in a box for this server
                            ForEach(serverPatients[serverIndex], id: \.id) { task in
                                VStack {
                                    Text("Patient ID: \(task.patientId)")
                                    Text("Start Time: \(task.startTime)")
                                    Text("End Time: \(task.endTime)")
                                    Text("Priority: \(task.priority)")
                                    Text("Service Time: \(task.endTime - task.startTime) min")
                                        .padding(.top)
                                }
                                .padding()
                                .frame(minHeight: 120)
                                .background(getPriorityColor(priority: task.priority))
                                .cornerRadius(10)
                                .foregroundColor(.white)
                                .shadow(radius: 5)
                            }
                        }
                    }
                    .padding()
                }
                .padding(.top)
               
            }
        }
        .padding()
    }

    // Helper function to assign colors based on priority
    private func getPriorityColor(priority: Int) -> Color {
        switch priority {
        case 1:
            return Color.red
        case 2:
            return Color.blue
        case 3:
            return Color.green
        default:
            return Color.gray
        }
    }
}

struct GanttChartView1: View {
    let patientIds: [Int]
    let startTimes: [Int]
    let endTimes: [Int]
    let priorities: [Int]?
    let numberOfServers: Int

    // Helper function to assign patients dynamically
    func simulatePatientAssignment() -> [[GanttChartView12.Task]] {
        var serverAssignments: [[Int]] = Array(repeating: [], count: numberOfServers)
        var serverEndTimes: [Int] = Array(repeating: 0, count: numberOfServers)
        var serverPatients: [[GanttChartView12.Task]] = Array(repeating: [], count: numberOfServers)

        var patientEndTimes: [Int] = Array(repeating: 0, count: patientIds.count)
        var waitingTimes: [Int] = Array(repeating: 0, count: patientIds.count)
        var turnaroundTimes: [Int] = Array(repeating: 0, count: patientIds.count)

        for i in 0..<patientIds.count {
            var assignedServer: Int?

            // Find the earliest free server
            for server in 0..<numberOfServers {
                if startTimes[i] >= serverEndTimes[server] {
                    assignedServer = server
                    break
                }
            }

            // If no free server is found, wait for the earliest free one
            if assignedServer == nil {
                assignedServer = serverEndTimes.firstIndex(of: serverEndTimes.min()!)!
            }

            // Assign patient to the chosen server
            let server = assignedServer!
            let startTime = max(startTimes[i], serverEndTimes[server]) // Start when server is free or at patient's arrival time
            let endTime = startTime + (endTimes[i] - startTimes[i])  // Calculate service time

            // Update server's end time
            serverEndTimes[server] = endTime

            // Assign task to the server
            let task = GanttChartView12.Task(patientId: patientIds[i], startTime: startTime, endTime: endTime, priority: priorities?[i] ?? 0)
            serverPatients[server].append(task)

            // Calculate waiting and turnaround times
            waitingTimes[i] = startTime - startTimes[i]
            turnaroundTimes[i] = endTime - startTimes[i]
            patientEndTimes[i] = endTime
        }

        return serverPatients
    }

    var body: some View {
        // Get the dynamically assigned patients based on availability
        let serverPatients = simulatePatientAssignment()

        return ScrollView {
            GanttChartView12(servers: numberOfServers, serverPatients: serverPatients)
        }
    }
}

#Preview {
    GanttChartView1(patientIds: [12, 34, 56], startTimes: [10, 15, 20], endTimes: [30, 45, 60], priorities: [1, 2, 3], numberOfServers: 3)
}
