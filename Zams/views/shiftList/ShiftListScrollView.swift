//
//  ShiftListScrollView.swift
//  Zams
//
//  Created by Lucas Capuani on 2021-03-29.
//

import SwiftUI

struct ShiftListScrollView: View {
    
    @EnvironmentObject var job: JobController
    
    var body: some View {
        
        ForEach(job.jobEntries.reversed(), id: \.self) { entry in
            ShiftListItemView(entry: entry)
                .padding(.trailing, 10)
                .padding(.leading, 10)
                .padding(.bottom, 5)
        }
        
    }
    
    private func getDateString (d: Date) -> String {
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd-MM-yyyy"
        
        return formatter.string(from: d)
        
    }
    
}

