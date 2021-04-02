//
//  JobSelectionView.swift
//  Zams
//
//  Created by Lucas Capuani on 2021-03-29.
//

import SwiftUI

struct JobSelectionView: View {
    
    @EnvironmentObject var job: JobController
    @State private var showing = false
    
    var body: some View {
        
        ZStack {
            
            Color.background
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack {
                
            
                HStack {
                    Spacer()
                    
                    Button(action: {
                        
                        showing.toggle()
                        
                    }, label: {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 28, height: 28)
                            .padding(.trailing, 30)
                            .foregroundColor(Color.white)
                    })
                    .sheet(isPresented: $showing, content: {
                        JobListingSheetView()
                            .environmentObject(job)
                    })
                    
                } // End hstack
                
                Text("Jobs")
                    .font(.system(size: 36))
                    .foregroundColor(Color.header)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                Spacer()
                
                if job.jobs.count == 0 {
                    
                    
                    Button(action: {
                        showing.toggle()
                    }, label: {
                        Text("Add Job")
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: 60)
                            .foregroundColor(.header)
                            .background(Color.ashphalt)
                    })
                    .cornerRadius(12)
                    .padding()
                    
                    Spacer()
                    
                } else {
                    
                    JobUpcomingPays()
                        .padding()
                    
                    ScrollView {
                        
                        ForEach(job.jobs, id: \.self) { j in
                            
                            JobListingView(jobName: j.name!, id: j.id!)
                                .padding()
                            
                        }
                        
                    }
                }
                
            
                
                
            } // End vstack
            
        } // End zstack
        
        
    }
}

struct JobSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        JobSelectionView()
    }
}
