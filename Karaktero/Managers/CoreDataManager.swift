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
        do {
            try moc.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteGrade(grade: Grade) {
        moc.delete(grade)
        do {
            try moc.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func editGrade(existingGrade: Grade, newTitle: String, newECTS: Int16, newGrade: Int16) {
        existingGrade.courseTitle = newTitle
        existingGrade.ects = newECTS
        existingGrade.grade = newGrade
        do {
            try moc.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
