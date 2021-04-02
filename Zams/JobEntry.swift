//
//  JobEntry.swift
//  Zams
//
//  Created by Lucas Capuani on 2021-03-28.
//

import Foundation

struct JobEntry {
    
    var uuid: UUID = UUID()
    var clockIn: Date
    var clockOut: Date
    var date: Date
    var wage: Double
    var parentId: UUID
    
}
