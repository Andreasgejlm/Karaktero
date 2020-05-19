//
//  GradeItemViewModel.swift
//  Karaktero
//
//  Created by Andreas Madsen on 18/05/2020.
//  Copyright © 2020 Madsen. All rights reserved.
//

import Foundation
import Combine


class GradeItemViewModel: ViewModel {
    @Published var state: GradeItemViewState
    
    func trigger(_ input: GradeItemViewInput) {
        
    }
    
    init(grade: Grade) {
        state = GradeItemViewState(grade: grade)
    }
    
}

struct GradeItemViewState: Identifiable {
    let id: UUID = UUID()
    var grade: Grade
}

enum GradeItemViewInput {

}
