//
//  GradeListViewModel.swift
//  Karaktero
//
//  Created by Andreas Madsen on 02/05/2020.
//  Copyright © 2020 Madsen. All rights reserved.
//

import Foundation
import Combine


class GradeListViewModel: ViewModel {
    var objectWillChange = PassthroughSubject<Void, Never>()
    @Published var state: GradeListState = GradeListState()
    var cdmanager: CoreDataManager
    
    func trigger(_ input: GradeListInput) {

    }
    
    init(cdmanager: CoreDataManager) {
        self.cdmanager = cdmanager
    }

    func fetchGrades() {
    }
}

