//
//  TotalIncomeView.swift
//  Zams
//
//  Created by Lucas Capuani on 2021-03-28.
//

import SwiftUI

struct TotalIncomeView: View {
    
    @EnvironmentObject var job: JobController
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("INCOME")
                .padding()
                .padding(.bottom, -20)
                .foregroundColor(.header)
            
            Text("$" + String(format: "%.2f", calculateIncome()))
                .padding()
                .foregroundColor(.green)
            
        }
        .frame(maxWidth: .infinity, maxHeight: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .background(Color.ashphalt)
        .cornerRadius(12)
    }
    
    private func calculateIncome () -> Double {
        
        var sum: Double = 0.00
        
        for j in job.jobEntries {
            sum += j.wage * j.hours
        }
        
        return sum
        
    }
    
}

struct TotalIncomeView_Previews: PreviewProvider {
    static var previews: some View {
        TotalIncomeView()
    }
}
