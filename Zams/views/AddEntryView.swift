//
//  AddEntryView.swift
//  Zams
//
//  Created by Lucas Capuani on 2021-03-28.
//

import SwiftUI

struct AddEntryView: View {
    
    @EnvironmentObject var job: JobController
    @State private var showing: Bool = false
    
    var body: some View {
        
        Button(action: {
            
            showing.toggle()
            
        }, label: {
            Text("ADD ENTRY")
                .foregroundColor(.header)
                .frame(maxWidth: .infinity, maxHeight: 60)
                .background(Color.ashphalt)
                .cornerRadius(12)
        })
        .sheet(isPresented: $showing) {
            AddEntrySheetView()
                .environmentObject(job)
        }
        
    }
}

struct AddEntryView_Previews: PreviewProvider {
    static var previews: some View {
        AddEntryView()
    }
}
