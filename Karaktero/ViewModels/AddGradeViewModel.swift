//
//  AddGradeViewModel.swift
//  Karaktero
//
//  Created by Andreas Madsen on 05/05/2020.
//  Copyright © 2020 Madsen. All rights reserved.
//

import Foundation
import Combine

class AddGradeViewModel: ViewModel {
    @Published var state: AddGradeViewState
    var cdmanager: CoreDataManager
    
    func trigger(_ input: AddGradeViewInput) {
        
    }
    
    init() {
        self.cdmanager = CoreDataManager()
        self.state = AddGradeViewState()
    }
    
}
