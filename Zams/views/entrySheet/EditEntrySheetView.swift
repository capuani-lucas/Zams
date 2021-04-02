//
//  EditEntrySheetView.swift
//  Zams
//
//  Created by Lucas Capuani on 2021-03-29.
//

import SwiftUI

struct EditEntrySheetView: View {
    
    @Environment(\.presentationMode) var pres
    @EnvironmentObject var job: JobController
    
    @State private var rate = ""
    
    @State private var clockIn: Date = Date()
    @State private var clockOut: Date = Date()
    
    @State private var hours: String = "00:00"
    @State private var errorMessage: String = ""
    
    var entry: Entry
    
    var body: some View {
        NavigationView {
            
            Form {
                
                if errorMessage != "" {
                    
                    Text(errorMessage)
                        .foregroundColor(.red)
                    
                }
                

                
                Section (header: Text("Shift")) {
                    
                    DatePicker("Clock in", selection: $clockIn)
                    DatePicker("Clock out", selection: $clockOut)
                    
                    
                } // End section
                .onAppear {
                    
                    rate = String(format: "%.2f", entry.wage)
                    clockIn = entry.clockIn!
                    clockOut = entry.clockOut!
                    
                }
                
                Section (header: Text("Rate $")) {
                    TextField("Hourly rate", text: $rate)
                        .keyboardType(.decimalPad)

                } // End section
                
                Button(action: {
                    
                    job.deleteEntry(id: entry.id!)
                    
                    pres.wrappedValue.dismiss()
                    
                }, label: {
                    HStack {
                        Spacer()
                        Text("Delete")
                            .foregroundColor(Color.red)
                        
                        Spacer()
                    }
                })
                
                
                Button(action: {
                    
                    
                    let w: Double? = Double(rate)
                    
                    if w == nil {
                        
                        errorMessage = "Please enter a valid number"
                        return
                        
                    }
                    
                    if clockOut < clockIn {
                        errorMessage = "Clock out date must be greater than clock in"
                        return
                    }
                    
                    job.editEntry(e: entry, clockIn: clockIn, clockOut: clockOut, wage: w!)
                    
                    
                    pres.wrappedValue.dismiss()
                    
                }, label: {
                    HStack {
                        Spacer()
                        Text("Save")
                        Spacer()
                    }
                })
                
            } // End form
            .navigationBarTitle("Edit Shift Entry")
            
            
        } // End navigation view
        

    }
}


