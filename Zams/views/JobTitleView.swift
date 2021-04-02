//
//  JobTitleView.swift
//  Zams
//
//  Created by Lucas Capuani on 2021-03-28.
//

import SwiftUI

struct JobTitleView: View {
    
    @EnvironmentObject var job: JobController
    @State private var showingSheet = false
    
    var body: some View {
        
        HStack {
            
            Button(action: {
                
                withAnimation {
                    job.currentJob = JobModelEmpty().job
                }
                
            }, label: {
                
                Image(systemName: "arrow.left")
                    .resizable()
                    .frame(width: 20, height: 20)
                
            })
            .foregroundColor(Color.header)
            
            Text(job.currentJob.name)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .foregroundColor(.header)
            
            Spacer()
            
            Button(action: {
                
                showingSheet.toggle()
                
            }, label: {
                Image(systemName: "pencil.circle")
                    .foregroundColor(.white)
            })
            .sheet(isPresented: $showingSheet, content: {
                JobEditSheetView()
                    .environmentObject(job)
            })
            
            
            
        }
        .padding()
        
        
    }
}


