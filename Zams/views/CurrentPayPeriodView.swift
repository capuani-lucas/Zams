//
//  CurrentPayPeriodView.swift
//  Zams
//
//  Created by Lucas Capuani on 2021-03-28.
//

import SwiftUI

struct CurrentPayPeriodView: View {
    
    @EnvironmentObject var job: JobController
    
    var body: some View {
        HStack {
            
            Spacer()
            
            Text("Next pay: " + getStringDate(d: job.getNextPay(lastPay: job.currentJob.lastPay, paySchedule: job.currentJob.paySchedule)))
            
            Spacer()
            
            Text(String(format: "%.2f", getPayrollHours()) + " hrs")
                        
            Spacer()
            
            Text("$" + String(format: "%.2f", getPayrollPay()))
                .foregroundColor(.green)
            
            Spacer()
            
        }
        .padding()
        .foregroundColor(.white)
        .frame(maxHeight: 50)
        .background(Color.ashphalt)
        .cornerRadius(12)
    }
    
    
    private func getStringDate (d: Date) -> String {
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "MMM d, y"
        
        
        return formatter.string(from: d)
        
    }
    
    private func getFilteredPayroll () -> [Entry] {
        
        return job.jobEntries.filter { j in
            let nextPay = job.getNextPay(lastPay: job.currentJob.lastPay, paySchedule: job.currentJob.paySchedule)
            return j.clockIn! >= job.subStractDates(d: nextPay) && j.clockIn! <= nextPay
        }
        
    }
    
    private func getPayrollHours () -> Double {
        
        var sum: Double = 0.00
        
        for j in getFilteredPayroll() {
            sum += j.hours
        }
        
        return sum
        
    }
    
    private func getPayrollPay () -> Double {
        
        var sum: Double = 0.00
        
        for j in getFilteredPayroll() {
            
            sum += j.hours * j.wage
            
        }
        
        return sum
    }
    
    
}

struct CurrentPayPeriodView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentPayPeriodView()
    }
}
