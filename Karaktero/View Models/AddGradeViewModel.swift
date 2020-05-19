//
//  AddGradeViewModel.swift
//  Karaktero
//
//  Created by Andreas Madsen on 19/05/2020.
//  Copyright © 2020 Madsen. All rights reserved.
//

import Foundation


class AddGradeViewModel: ViewModel {
    @Published var state: AddGradeViewState
    
    func trigger(_ input: AddGradeViewInput) {
        switch input {
        case .addGrade(let title, let ects, let grade):
            addGrade(title: title, ects: ects, grade: grade)
        }
    }
    
    init() {
        state = AddGradeViewState()
    }
    
    func addGrade(title: String, ects: Int16, grade: Int16) {
        CoreDataManager.shared.saveNewGrade(courseTitle: title, ects: ects, grade: grade)
    }
    
}

struct AddGradeViewState {
    
}

enum AddGradeViewInput {
    case addGrade(title: String, ects: Int16, grade: Int16)
}
