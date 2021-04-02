//
//  JobController.swift
//  Zams
//
//  Created by Lucas Capuani on 2021-03-28.
//

import Combine
import CoreData

class JobController : ObservableObject {

    @Published var jobName: String = ""
    @Published var jobWage: Double = 0.00
    
    @Published var currentJob: JobModel = JobModelEmpty().job
    
    @Published var jobEntries: [Entry] = []
    @Published var jobs: [Job] = []
    
    private let context: NSManagedObjectContext
    
    let weekValues = ["weekly" : 1, "biweekly" : 2, "monthly" : 4, "yearly" : 52]

    
    init (context: NSManagedObjectContext) {
        self.context = context
        
        // Fetch all jobs on startup
        
        self.jobs = try! context.fetch(Job.fetchRequest())
//        self.jobEntries = try! context.fetch(Entry.fetchRequest())
    }
    
    func setCurrentJob (id: UUID) -> Void {
        
        // Get all entries after new job is selected on screen
        jobEntries = []
        
        let fetchRequest = NSFetchRequest<Entry>(entityName: "Entry")
        // Filter job entries to match id of job
        fetchRequest.predicate = NSPredicate(format: "parentID == %@", id.uuidString)
        
        self.jobEntries = try! context.fetch(fetchRequest)
        
        // Change current job 
        for j in jobs {
            if j.id == id {
                currentJob = JobModel(name: j.name!, defaultWage: j.defaultWage, id: j.id!, lastPay: j.lastPay!, paySchedule: j.paySchedule!, defaultModel: false)
            }
        }
        
    }
    
    func editJob (name: String, defaultWage: Double, lastPay: Date, paySchedule: String) -> Void {
        
        for j in jobs {
            if j.id == currentJob.id {
                
                j.name = name
                j.defaultWage = defaultWage
                j.lastPay = lastPay
                j.paySchedule = paySchedule
                
                currentJob.name = name
                currentJob.defaultWage = defaultWage
                currentJob.lastPay = lastPay
                currentJob.paySchedule = paySchedule
                
            }
        }
        
        try? context.save()
        
    }
    
    
    func createJob (j: JobModel) -> Void {
        
        let job = Job(context: self.context)
        
        job.name = j.name
        job.defaultWage = j.defaultWage
        job.lastPay = j.lastPay
        job.id = j.id
        job.paySchedule = j.paySchedule
        
        try? self.context.save()
        
        jobs.append(job)
        
    }
    
    func deleteJob () -> Void {
        
        for (index, j) in jobs.enumerated() {
            if j.id == currentJob.id {
                context.delete(j)
                jobs.remove(at: index)
            }
        }
        
        for e in jobEntries {
            context.delete(e)
        }
        
        jobEntries = []
        
        currentJob = JobModelEmpty().job
        
        try? context.save()
        
        
    }
    
    
    func add (e: JobEntry) -> Void {
        
        let entry = Entry(context: self.context)
        
        entry.date = e.date
        entry.clockIn = e.clockIn
        entry.clockOut = e.clockOut
        entry.wage = e.wage
        entry.hours = getHours(from: e.clockIn, to: e.clockOut)
        entry.id = e.uuid
        entry.parentID = e.parentId
        
        try? self.context.save()
        
        jobEntries.append(entry)
        
    }
    
    private func getHours (from: Date, to: Date) -> Double {
        
        let comp = Calendar.current.dateComponents([.hour, .minute], from: from, to: to)
        
        return Double(comp.hour!) + (Double(comp.minute!) / 60.00)
        
        
    }
    
    func editEntry (e: Entry, clockIn: Date, clockOut: Date, wage: Double) -> Void {
        
        e.date = clockIn
        e.clockIn = clockIn
        e.clockOut = clockOut
        e.wage = wage
        e.hours = getHours(from: clockIn, to: clockOut)
        
        try? self.context.save()
        
        
        for (index, entry) in jobEntries.enumerated() {
            if entry.id == e.id {
                jobEntries[index] = e
            }
            
        }
        
        
    }
    
    func deleteAllEntries () -> Void {
    
        
        for entry in jobEntries {
            self.context.delete(entry)
        }
        
        jobEntries = []
        
        try? self.context.save()
        
    }
    
    
    func deleteEntry (id: UUID) -> Void {
        
        for (index,entry) in jobEntries.enumerated() {
            
            if entry.id == id {
                jobEntries.remove(at: index)
                
                self.context.delete(entry)
                
            }
            
        }
        
        try? self.context.save()
        
    }
    
    func getNextPay (lastPay: Date, paySchedule: String) -> Date {
        
        var date = lastPay
        
        while date < Date() {
            
            date = Calendar.current.date(byAdding: .weekOfYear, value: weekValues[paySchedule]!, to: date)!

        }
        
        
        return date
        
    }
    
    func subStractDates (d: Date) -> Date {
        return Calendar.current.date(byAdding: .weekOfYear, value: weekValues[currentJob.paySchedule]!, to: d)!
        
    }
    
    
    

}

