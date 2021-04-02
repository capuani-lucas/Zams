//
//  JobListingView.swift
//  Zams
//
//  Created by Lucas Capuani on 2021-03-29.
//

import SwiftUI

struct JobListingView: View {
    
    var jobName: String
    var id: UUID
    
    @EnvironmentObject var job: JobController
    
    var body: some View {
        
        
        Text(jobName)
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 50, alignment: .leading)
            .foregroundColor(Color.header)
            .background(Color.ashphalt)
            .cornerRadius(12)
            .onTapGesture {
                
                withAnimation {
                    job.setCurrentJob(id: id)
                }
                
            }
    
        
    }
}


