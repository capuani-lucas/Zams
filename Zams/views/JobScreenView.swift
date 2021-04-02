//
//  JobScreenView.swift
//  Zams
//
//  Created by Lucas Capuani on 2021-03-29.
//

import SwiftUI

struct JobScreenView: View {
    
    @EnvironmentObject var job: JobController
    
    @State private var opacity = 1.0
    
    var body: some View {
        
        if job.currentJob.defaultModel {
            
            JobSelectionView()
            
            
        } else {
            VStack {
                
                JobTitleView()
                
                HStack {
                    HoursWorkedView()
                        .padding(.leading, 10)
                    TotalIncomeView()
                        .padding(.trailing, 10)
                } // End HStack
                
                
                CurrentPayPeriodView()
                    .padding(.top, 10)
                    .padding(.trailing, 10)
                    .padding(.leading, 10)
                
                ShiftListItemTitle()
                    .padding(.top, 20)
                    .padding(.trailing, 10)
                    .padding(.leading, 10)
                
                
                ScrollView {
                    
                    Color.clear
                    
                    ShiftListScrollView()

                    
                } // End scroll view
                .onTapGesture {
                    
                }
                .gesture(
                    DragGesture()
                        .onChanged { v in
                            if v.startLocation.x > 20 {
                                return
                            }

                            if v.location.x < v.startLocation.x {
                                return
                            }

                            opacity = opacity - 0.2
                            
                            if opacity <= 0 {
                                job.currentJob = JobModelEmpty().job
                                opacity = 1
                            }

                        }
                        .onEnded { v in

                            opacity = 1.0

                        }
                )
                
                AddEntryView()
                    .padding()
                
                
                Spacer()
            } // End VStack
            .opacity(opacity)

            
        }
        
    }
}

