//
//  CoreDataManager.swift
//  Karaktero
//
//  Created by Andreas Madsen on 18/05/2020.
//  Copyright © 2020 Madsen. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared: CoreDataManager = CoreDataManager(moc: NSManagedObjectContext.current)
    var moc: NSManagedObjectContext
    
    private init(moc: NSManagedObjectContext) {
        self.moc = moc
    }
    
    func saveNewGrade(courseTitle: String, ects: Int16, grade: Int16) {
        let newGrade = Grade(context: moc)
        newGrade.courseTitle = courseTitle
        newGrade.ects = ects
        newGrade.grade = grade
        newGrade.timestamp = Date().timeIntervalSince1970
        print(newGrade)
        do {
            try moc.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchAllGrades() -> [Grade] {
        var grades: [Grade] = [Grade]()
        let gradeRequest: NSFetchRequest<Grade> = Grade.fetchRequest()
        
        do {
            grades = try moc.fetch(gradeRequest)
        } catch {
            print(error.localizedDescription)
        }
        return grades
    }
    
    func editGrade(existingGrade: Grade, updatedGrade: Grade) {
        existingGrade.courseTitle = updatedGrade.courseTitle
        existingGrade.ects = updatedGrade.ects
        existingGrade.grade = updatedGrade.grade
        existingGrade.timestamp = updatedGrade.timestamp
        do {
            try moc.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
