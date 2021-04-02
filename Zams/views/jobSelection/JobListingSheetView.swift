//
//  JobListingSheetView.swift
//  Zams
//
//  Created by Lucas Capuani on 2021-03-29.
//

import SwiftUI

struct JobListingSheetView: View {
    
    @State private var jobName: String = ""
    @State private var index: Int = 0
    @State private var date: Date = Date()
    @State private var pay: String = ""
    
    @State private var errorMessage: String = ""
    
    private var options: [String] = ["weekly", "biweekly", "monthly", "yearly"]
    
    @EnvironmentObject var job: JobController
    @Environment(\.presentationMode) var pres
    
    var body: some View {
        
        NavigationView {
            
            Form {
                
                if errorMessage != "" {
                    
                    Text(errorMessage)
                        .foregroundColor(.red)
                    
                }
                
                
                Section(header: Text("Job")) {
                    
                    TextField("Job Name", text: $jobName)
                    
                }
                
                Section (header: Text("Pay")) {
                    
                    Picker (selection: $index, label: Text("Pay Schedule")) {
                     
                        ForEach(0..<options.count) {
                            Text(options[$0])
                        }
                        
                    }
                    
                    DatePicker("Last paycheck", selection: $date)
                    
                    
                    TextField("Rate", text: $pay)
                        .keyboardType(.decimalPad)
                    
                    
        
                    
                }
        
                Button(action: {
                    
                    let w: Double? = Double(pay)
                    
                    if jobName == "" {
                        errorMessage = "Please enter a valid job name"
                        return
                    }
                    
                    if w == nil {
                        
                        errorMessage = "Please enter a valid number"
                        return
                        
                    }
                    
                    if date > Date() {
                        errorMessage = "Last pay must come before current date"
                        return
                    }
                    
                    job.createJob(j: JobModel(name: jobName, defaultWage: w!, id: UUID(), lastPay: date, paySchedule: options[index], defaultModel: false))
                    
                    pres.wrappedValue.dismiss()
                    
                    
                }, label: {
                    HStack {
                        Spacer()
                        Text("Save")
                        Spacer()
                    }
                })
                
            } // End form
            .navigationBarTitle("New Job")
            
        } // End navigation view
        
        
        
    }
}

struct JobListingSheetView_Previews: PreviewProvider {
    static var previews: some View {
        JobListingSheetView()
    }
}
