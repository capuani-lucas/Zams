//
//  AddEntrySheetView.swift
//  Zams
//
//  Created by Lucas Capuani on 2021-03-28.
//

import SwiftUI

struct AddEntrySheetView: View {
    
    @Environment(\.presentationMode) var pres
    @EnvironmentObject var job: JobController
    
    @State private var rate = ""
    
    @State private var clockIn: Date = Date()
    @State private var clockOut: Date = Date()
    
    @State private var hours: String = "00:00"
    @State private var errorMessage: String = ""
    
    var body: some View {
        
       
        NavigationView {
            
            Form {
                
                if errorMessage != "" {
                    
                    Text(errorMessage)
                        .foregroundColor(.red)
                    
                }
                
                Text("Hours: \(hours)")
                
                Section (header: Text("Shift")) {
                    
                    DatePicker("Clock in", selection: $clockIn)
                    DatePicker("Clock out", selection: $clockOut)
                    
                    
                } // End section
                
                Section (header: Text("Rate $")) {
                    TextField("Hourly rate", text: $rate)
                        .keyboardType(.decimalPad)
                        .onAppear {
                            rate = String(job.currentJob.defaultWage)
                        }
                } // End section
                
                Button(action: {
                    
                    let comp = Calendar.current.dateComponents([.hour, .minute], from: clockIn, to: clockOut)
                    hours = String(format: "%02d", comp.hour!) + ":" + String(format: "%02d", comp.minute!)
                    
                }, label: {
                    HStack {
                        Spacer()
                        Text("Check")
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
                    
                    job.add(e: JobEntry(clockIn: clockIn, clockOut: clockOut, date: clockIn, wage: w!, parentId: job.currentJob.id))
                    
                    
                    pres.wrappedValue.dismiss()
                    
                }, label: {
                    HStack {
                        Spacer()
                        Text("Save")
                        Spacer()
                    }
                })
                
            } // End form
            .navigationBarTitle("New Shift Entry")
            
            
        } // End navigation view
        
    } // End view
    
    
    
    
}

struct AddEntrySheetViewPreview : View {
    @Environment(\.managedObjectContext) var context
    var body: some View {
        AddEntrySheetView()
            .environmentObject(JobController(context: context))
    }
}


struct AddEntrySheetView_Previews: PreviewProvider {
    static var previews: some View {
        AddEntrySheetViewPreview()
    }
}

class ReceiveDate : ObservableObject {
    @Published var d: Date = Date()
}
