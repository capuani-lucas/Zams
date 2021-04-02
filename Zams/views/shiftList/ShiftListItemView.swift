//
//  ShiftListView.swift
//  Zams
//
//  Created by Lucas Capuani on 2021-03-28.
//

import SwiftUI

struct ShiftListItemView: View {
    

    var entry: Entry
    
    @EnvironmentObject var job: JobController
    
    @State private var showing: Bool = false
    
    var body: some View {
        
       
        HStack {
            
            Text(getDateString(d: entry.clockIn!))
            
            Spacer()
            
            Text(String(format: "%.2f", entry.hours))
            
            Spacer()
            
            Text("$" + String(format: "%.2f", entry.wage))
            
            Spacer()
            
            Text("$" + String(format: "%.2f", entry.hours * entry.wage))
                .foregroundColor(.green)
            
        }
        .onTapGesture {
            showing.toggle()
        }
        .sheet(isPresented: $showing) {
            EditEntrySheetView(entry: entry)
                .environmentObject(job)
        }
        .padding()
        .foregroundColor(.white)
        .frame(maxHeight: 50)
        .background(Color.ashphalt)
        .cornerRadius(12)
        
    }
    
    private func getDateString (d: Date) -> String {
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd-MM-yyyy"
        
        return formatter.string(from: d)
        
    }
    
}

struct ShiftListItemView_Previews: PreviewProvider {
    static var previews: some View {
        ShiftListItemView(entry: Entry())
    }
}
