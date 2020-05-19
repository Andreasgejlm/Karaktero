//
//  GradeListViewModel.swift
//  Karaktero
//
//  Created by Andreas Madsen on 18/05/2020.
//  Copyright © 2020 Madsen. All rights reserved.
//

import Foundation
import Combine


class GradeListViewModel: ViewModel {
    @Published var state: GradeListViewState = GradeListViewState(grades: [])
    
    func trigger(_ input: GradeListViewInput) {
        
    }
    
    init() {
        state.grades = CoreDataManager.shared.fetchAllGrades().map { AnyViewModel(GradeItemViewModel(grade: $0)) }
    }
}

struct GradeListViewState: Identifiable {
    let id: UUID = UUID()
    var grades: [AnyViewModel<GradeItemViewState, GradeItemViewInput>]

}

enum GradeListViewInput {

}
