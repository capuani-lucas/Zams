//
//  HoursWorkedView.swift
//  Zams
//
//  Created by Lucas Capuani on 2021-03-28.
//

import SwiftUI

struct HoursWorkedView: View {
    
    @EnvironmentObject var job: JobController
    
    var body: some View {
        
        
        VStack(alignment: .leading) {
            
            Text("HOURS")
                .padding()
                .padding(.bottom, -20)
            
            Text(String(format: "%.2f", calculateHours()))
                .padding()
            
        }
        .foregroundColor(.header)
        .frame(maxWidth: .infinity, maxHeight: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .background(Color.ashphalt)
        .cornerRadius(12)
        
    }
    
    private func calculateHours () -> Double {
        
        var sum: Double = 0.00
        
        for j in job.jobEntries {
            sum += j.hours
        }
        
        return sum
        
    }
    
}

struct HoursWorkedView_Previews: PreviewProvider {
    static var previews: some View {
        HoursWorkedView()
    }
}
