import SwiftUI

struct PatientData {
    let patientIds: [Int]
    let arrivalTimes: [Int]
    let startTimes: [Int]
    let serviceTimes: [Int]
    let endTimes: [Int]
    let waitingTimes: [Int]
    let turnaroundTimes: [Int]
    let responseTimes: [Int]
    let priorities: [Int]
    let numberOfServer : Int
    let interArrivals: [Int]
    
    func combinedDataForPriority1() -> (patientIds: [Int], arrivalTimes: [Int], startTimes: [Int], serviceTimes: [Int], endTimes: [Int], waitingTimes: [Int], turnaroundTimes: [Int], responseTimes: [Int],priorities: [Int], interArrivals: [Int]) {
        
        // Filter for priority 1
        let priority1Data = filterData(for: 1)
        // Filter for priority 2
        let priority2Data = filterData(for: 2)
        // Filter for priority 3
        let priority3Data = filterData(for: 3)
        
        // Combine all priorities into priority 1 arrays
        let combinedPatientIds = priority1Data.patientIds + priority2Data.patientIds + priority3Data.patientIds
        let combinedArrivalTimes = priority1Data.arrivalTimes + priority2Data.arrivalTimes + priority3Data.arrivalTimes
        let combinedStartTimes = priority1Data.startTimes + priority2Data.startTimes + priority3Data.startTimes
        let combinedServiceTimes = priority1Data.serviceTimes + priority2Data.serviceTimes + priority3Data.serviceTimes
        let combinedEndTimes = priority1Data.endTimes + priority2Data.endTimes + priority3Data.endTimes
        let combinedWaitingTimes = priority1Data.waitingTimes + priority2Data.waitingTimes + priority3Data.waitingTimes
        let combinedTurnaroundTimes = priority1Data.turnaroundTimes + priority2Data.turnaroundTimes + priority3Data.turnaroundTimes
        let combinedResponseTimes = priority1Data.responseTimes + priority2Data.responseTimes + priority3Data.responseTimes
        let combinedPriorities = priority1Data.priorities + priority2Data.priorities + priority3Data.priorities
        let combinedinterArrivals = priority1Data.interArrivals + priority2Data.interArrivals + priority3Data.interArrivals
        
        
        return (combinedPatientIds, combinedArrivalTimes, combinedStartTimes, combinedServiceTimes, combinedEndTimes, combinedWaitingTimes, combinedTurnaroundTimes, combinedResponseTimes,combinedPriorities,combinedinterArrivals)
    }
    
    private func filterData(for priority: Int) -> (patientIds: [Int], arrivalTimes: [Int], startTimes: [Int], serviceTimes: [Int], endTimes: [Int], waitingTimes: [Int], turnaroundTimes: [Int], responseTimes: [Int], priorities: [Int], interArrivals: [Int]) {
        let indices = priorities.indices.filter { priorities[$0] == priority }
        let filteredPatientIds = indices.map { patientIds[$0] }
        let filteredArrivalTimes = indices.map { arrivalTimes[$0] }
        let filteredServiceTimes = indices.map { serviceTimes[$0] }
        let filteredEndTimes = indices.map { endTimes[$0] }
        let filteredWaitingTimes = indices.map { waitingTimes[$0] }
        let filteredTurnaroundTimes = indices.map { turnaroundTimes[$0] }
        let filteredResponseTimes = indices.map { responseTimes[$0] }
        let filteredPriorities = indices.map { priorities[$0] }
        let filteredInterArrivals = indices.map { interArrivals[$0] }
        
        // Initialize modifiedEndTimes array first
        var modifiedEndTimes: [Int] = []

        // Modify filteredEndTimes based on modifiedStartTimes and filteredServiceTimes
        for (index, _) in filteredServiceTimes.enumerated() {
            if index == 0 {
                // First element sum of filteredArrivalTimes[0] and filteredServiceTimes[0]
                modifiedEndTimes.append(filteredArrivalTimes[0] + filteredServiceTimes[index])
            } else {
                // Sum of corresponding filteredArrivalTimes and filteredServiceTimes
                modifiedEndTimes.append(filteredArrivalTimes[index] + filteredServiceTimes[index])
            }
        }

        // Now, modify filteredStartTimes based on modifiedEndTimes
        var modifiedStartTimes: [Int] = []
        for (index, _) in filteredEndTimes.enumerated() {
            if index == 0 {
                // First element remains unchanged, same as filteredArrivalTimes[0]
                modifiedStartTimes.append(filteredArrivalTimes[index])
            } else {
                if filteredArrivalTimes[index] > modifiedEndTimes[index - 1] {
                    modifiedStartTimes.append(filteredArrivalTimes[index])
                }else {
                    // Use the previous element of modifiedEndTimes for the new start time
                    modifiedStartTimes.append(modifiedEndTimes[index - 1])
                }
                
            }
        }


        
        // Calculate waitingTimes, turnaroundTimes, and responseTimes based on formulas
           var modifiedWaitingTimes: [Int] = []
           var modifiedTurnaroundTimes: [Int] = []
           var modifiedResponseTimes: [Int] = []

           for (index, _) in filteredArrivalTimes.enumerated() {
               // Waiting Time: Start Time - Arrival Time
               modifiedWaitingTimes.append(modifiedStartTimes[index] - filteredArrivalTimes[index])

               // Turnaround Time: End Time - Arrival Time
               modifiedTurnaroundTimes.append(modifiedEndTimes[index] - filteredArrivalTimes[index])

               // Response Time: Start Time - Arrival Time
               modifiedResponseTimes.append(modifiedStartTimes[index] - filteredArrivalTimes[index])
           }

           return (filteredPatientIds, filteredArrivalTimes, modifiedStartTimes, filteredServiceTimes, modifiedEndTimes, modifiedWaitingTimes, modifiedTurnaroundTimes, modifiedResponseTimes, filteredPriorities, filteredInterArrivals)
    }



}

struct ContentView1: View {
    
    
    let patientIds : [Int]
    let arrivalTimes : [Int]
    let startTimes : [Int]
    let serviceTimes : [Int]
    let endTimes : [Int]
    let waitingTimes : [Int]
    let turnaroundTimes : [Int]
    let responseTimes : [Int]
    let priorities : [Int]
    let numberOfServer : Int
    let server : [[Int]]
    let interArrivals: [Int]
    
    
//    let data = PatientData(
//        patientIds: [1, 2, 3, 4, 5, 6, 7, 8],
//        arrivalTimes: [10, 20, 30, 40, 50, 60, 70, 80],
//        startTimes: [15, 25, 35, 45, 55, 65, 75, 85],
//        serviceTimes: [5, 5, 5, 5, 5, 5, 5, 5],
//        endTimes: [20, 30, 40, 50, 60, 70, 80, 90],
//        waitingTimes: [5, 5, 5, 5, 5, 5, 5, 5],
//        turnaroundTimes: [10, 10, 10, 10, 10, 10, 10, 10],
//        responseTimes: [5, 5, 5, 5, 5, 5, 5, 5],
//        priorities: [1, 2, 3, 1, 2, 3, 1, 3], numberOfServer: 2
//    )
    
    
    var body: some View {
        
        let data = PatientData(
            patientIds: patientIds,
            arrivalTimes: arrivalTimes,
            startTimes: startTimes,
            serviceTimes: serviceTimes,
            endTimes: endTimes,
            waitingTimes: waitingTimes,
            turnaroundTimes: turnaroundTimes,
            responseTimes: responseTimes,
            priorities: priorities, numberOfServer: numberOfServer, interArrivals: interArrivals
        )
        
        let combinedData = data.combinedDataForPriority1()
        
        
        
//        let caller = callme(mamaInstance: mama)
        
//        VStack(spacing: 10) {
//            Text("Combined Data for Priority 1")
//                .font(.title2)
//                .padding()
            
        PatientDataView(patientIds: combinedData.patientIds, arrivalTimes: combinedData.arrivalTimes, startTimes: combinedData.startTimes, serviceTimes: combinedData.serviceTimes, endTimes: combinedData.endTimes, waitingTimes: combinedData.waitingTimes, turnaroundTimes: combinedData.turnaroundTimes, responseTimes: combinedData.responseTimes, serverAssignments: server, priorities: combinedData.priorities ?? [0], interArrivals: combinedData.interArrivals, numberOfServers: numberOfServer)
//            ScrollView {
//                VStack(alignment: .leading, spacing: 8) {
//                    
//                    
//                    Text("Patient IDs: \(combinedData.patientIds.description)")
//                    Text("Arrival Times: \(combinedData.arrivalTimes.description)")
//                    Text("Start Times: \(combinedData.startTimes.description)")
//                    Text("Service Times: \(combinedData.serviceTimes.description)")
//                    Text("End Times: \(combinedData.endTimes.description)")
//                    Text("Waiting Times: \(combinedData.waitingTimes.description)")
//                    Text("Turnaround Times: \(combinedData.turnaroundTimes.description)")
//                    Text("Response Times: \(combinedData.responseTimes.description)")
//                    Text("Priorities : \(combinedData.priorities.description)")
//                }
//                .padding()
//                .background(Color(.systemGray6))
//                .cornerRadius(8)
//            }
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//        }
//        .padding()
    }
}

#Preview {
    ContentView1(
        patientIds: [1, 2, 3, 4, 5, 6, 7, 8],
        arrivalTimes: [10, 20, 30, 40, 50, 60, 70, 80],
        startTimes: [15, 25, 35, 45, 55, 65, 75, 85],
        serviceTimes: [5, 5, 5, 5, 5, 5, 5, 5],
        endTimes: [20, 30, 40, 50, 60, 70, 80, 90],
        waitingTimes: [5, 5, 5, 5, 5, 5, 5, 5],
        turnaroundTimes: [10, 10, 10, 10, 10, 10, 10, 10],
        responseTimes: [5, 5, 5, 5, 5, 5, 5, 5],
        priorities: [1, 2, 3, 1, 2, 3, 1, 3], numberOfServer: 2, server: [[1,2,3,4,5,6,7,8]], interArrivals: [1, 2, 3, 1, 2, 3, 1, 3]
    )
}
