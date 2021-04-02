//
//  JobModel.swift
//  Zams
//
//  Created by Lucas Capuani on 2021-03-29.
//

import Foundation

struct JobModel {
    
    var name: String
    var defaultWage: Double
    var id: UUID
    var lastPay: Date
    var paySchedule: String
    var defaultModel: Bool
    
}

struct JobModelEmpty {
    
    var job: JobModel = JobModel(name: "", defaultWage: 0.00, id: UUID(), lastPay: Date(), paySchedule: "biweekly", defaultModel: true)
    
}
