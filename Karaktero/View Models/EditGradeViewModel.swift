//
//  EditGradeViewMode.swift
//  Karaktero
//
//  Created by Andreas Madsen on 20/05/2020.
//  Copyright © 2020 Madsen. All rights reserved.
//

import Foundation


class EditGradeViewModel: ViewModel {
    @Published var state: EditGradeViewState
    
    func trigger(_ input: EditGradeViewInput) {
        switch input {
        case .editGrade(let title, let ects, let grade):
            editGrade(newtitle: title, newects: ects, newgrade: grade)
        }
    }
    
    init(grade: Grade) {
        state = EditGradeViewState(grade: grade)
    }
    
    func editGrade(newtitle: String, newects: Int16, newgrade: Int16) {
        CoreDataManager.shared.editGrade(existingGrade: state.grade, newTitle: newtitle, newECTS: newects, newGrade: newgrade)
    }
}

struct EditGradeViewState {
    var grade: Grade
}

enum EditGradeViewInput {
    case editGrade(newtitle: String, newects: Int16, newgrade: Int16)
}
