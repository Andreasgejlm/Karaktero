//
//  MainListViewModel.swift
//  Karaktero
//
//  Created by Andreas Madsen on 19/05/2020.
//  Copyright © 2020 Madsen. All rights reserved.
//

import Foundation


class MainListViewModel: ViewModel {
    @Published var state: MainListViewState
    
    func trigger(_ input: MainListViewInput) {
        switch input {
        case .fetch:
            fetchAllGrades()
        default:
            return
        }
    }
    
    init() {
        let grades = CoreDataManager.shared.fetchAllGrades()
        state = MainListViewState(grades: grades)
    }
    
    func fetchAllGrades() {
        print("Fetching")
        state.grades = CoreDataManager.shared.fetchAllGrades().map { AnyViewModel(GradeItemViewModel(grade: $0)) }
    }
    
}

struct MainListViewState {
    var grades: [Grade]
}

enum MainListViewInput {
    case fetch
}
