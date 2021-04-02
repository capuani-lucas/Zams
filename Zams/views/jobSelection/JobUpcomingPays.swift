//
//  JobUpcomingPays.swift
//  Zams
//
//  Created by Lucas Capuani on 2021-03-30.
//

import SwiftUI

struct JobUpcomingPays: View {
    
    @EnvironmentObject var job: JobController
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Text("Upcoming paychecks:\n")
            
            
            ForEach(getUpcomingPays().prefix(3), id: \.self) { p in
                
                HStack {
                    Text(p.name)
                    Spacer()
                    Text(String(p.days) + (p.days > 1 ? " days" : " day"))
                }
                
                
                Divider()
                    .background(Color.white)
                
            }
        
            
        }
        .padding()
        .foregroundColor(Color.header)
        .background(Color.ashphalt)
        .cornerRadius(12)
        
    }
    
    private func getUpcomingPays () -> [UpcomingPay] {
        
        var js: [UpcomingPay] = []
        
        
        for j in job.jobs {
            
            js.append(UpcomingPay(name: j.name!, days: getDaysBetween(d1: Date(), d2: job.getNextPay(lastPay: j.lastPay!, paySchedule: j.paySchedule!)) + 1))
            
        }
        
        js.sort {
            $0.days < $1.days
        }
        
        return js
    }
    
    private func getDaysBetween (d1: Date, d2: Date) -> Int {
        
        return Calendar.current.dateComponents([.day], from: d1, to: d2).day!
        
    }
    
}

struct JobUpcomingPays_Previews: PreviewProvider {
    static var previews: some View {
        JobUpcomingPays()
    }
}

struct UpcomingPay : Hashable {
    var name: String
    var days: Int
}
