//
//  GradeAverageViewModel.swift
//  Karaktero
//
//  Created by Andreas Madsen on 19/05/2020.
//  Copyright © 2020 Madsen. All rights reserved.
//

import Foundation


class GradeAverageViewModel: ViewModel {
    @Published var state: GradeAverageViewState
    
    func trigger(_ input: GradeAverageViewInput) {
        switch input {
        case .calculateAverage:
            calculateAverageGrade()
        default:
            return
        }
    }
    
    init() {
        let grades: [Grade] = CoreDataManager.shared.fetchAllGrades()
        state = GradeAverageViewState(grades: grades, averageString: " - ", sumECTSString: "0")
    }
    
    func calculateAverageGrade() {
        let sumEcts: Int16 = state.grades.map{$0.ects}.reduce(0, +)
        let sumWeights = state.grades.map { $0.ects * $0.grade }.reduce(0, +)
        let avg: Double? = sumEcts > 0 ? Double( sumWeights ) / Double( sumEcts ) : nil
        if let avg = avg {
            state.averageString = String(format: "%.1f", avg)
        } else {
            state.averageString = " - "
        }
        state.sumECTSString = String(format: "%.1f", sumEcts)
    }
}


struct GradeAverageViewState {
    var grades: [Grade]
    var averageString: String
    var sumECTSString: String
}

enum GradeAverageViewInput {
    case calculateAverage
}
