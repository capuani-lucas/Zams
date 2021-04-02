//
//  JobEditSheetView.swift
//  Zams
//
//  Created by Lucas Capuani on 2021-03-29.
//

import SwiftUI

struct JobEditSheetView: View {
    
    @State private var jobName: String = ""
    @State private var defaultWage: String = ""
    @State private var lastPay: Date = Date()
    
    @State private var index = 0
    
    private var options: [String] = ["weekly", "biweekly", "monthly", "yearly"]
    
    @State private var errorMessage: String = ""
    
    @State private var alertShowing = false
    
    @Environment(\.presentationMode) var pres
    @EnvironmentObject var job: JobController
    
    @State private var initial = false
    
    var body: some View {
        
        
        NavigationView {
            
            Form {
                
                if errorMessage != "" {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
                
                TextField("Job Name", text: $jobName)
                    .onAppear {
                        
                        if !initial {
                            jobName = job.currentJob.name
                            defaultWage = String(format: "%.2f", job.currentJob.defaultWage)
                            lastPay = job.subStractDates(d: job.getNextPay(lastPay: job.currentJob.lastPay, paySchedule: job.currentJob.paySchedule))
                            
                            for (i, value) in options.enumerated() {
                                if value == job.currentJob.paySchedule {
                                    index = i
                                }
                            }
                            
                            initial = true
                        }
                        
                        
                    }
                
                TextField("Default Wage", text: $defaultWage)
                    .keyboardType(.decimalPad)
                
                DatePicker("Last paycheck", selection: $lastPay)
                
                Picker (selection: $index, label: Text("Pay Schedule")) {
                 
                    ForEach(0..<options.count) {
                        Text(options[$0])
                    }
                    
                }
                
                Button(action: {
                    
                    alertShowing = true
                    
                }, label: {
                    HStack {
                        Spacer()
                        Text("Delete")
                            .foregroundColor(.red)
                        Spacer()
                    }
                })
                .alert(isPresented: $alertShowing) {
                    Alert(title: Text("Are you sure you want to delete this job and all of its entries?"),
                          message: Text("You are unable to recover all entries"),
                          primaryButton: .destructive(Text("Delete")) {
                            
                            job.deleteJob()
                            
                            pres.wrappedValue.dismiss()
                            
                          },
                          secondaryButton: .cancel()
                          )
                }
                
                
                Button(action: {
                    
                    let w: Double? = Double(defaultWage)
                    
                    if jobName == "" {
                        errorMessage = "Please enter a valid job name"
                        return
                    }
                    
                    if w == nil {
                        errorMessage = "Please enter a valid wage"
                        return
                    }
                    
                    if lastPay > Date() {
                        errorMessage = "Last pay must come before current date"
                        return
                    }
                    
                    job.editJob(name: jobName, defaultWage: w!, lastPay: lastPay, paySchedule: options[index])
                    pres.wrappedValue.dismiss()
                    
                }, label: {
                    HStack {
                        Spacer()
                        Text("Save")
                        Spacer()
                    }
                })
                
                
            }
            .navigationBarTitle("Edit Job")
        }
        
        
    }
}

struct JobEditSheetView_Previews: PreviewProvider {
    static var previews: some View {
        JobEditSheetView()
    }
}
