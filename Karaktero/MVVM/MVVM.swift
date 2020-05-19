//
//  MVVM.swift
//  Karaktero
//
//  Created by Andreas Madsen on 18/05/2020.
//  Copyright © 2020 Madsen. All rights reserved.
//

import Foundation
import Combine


protocol ViewModel: ObservableObject where ObjectWillChangePublisher.Output == Void {
    associatedtype State
    associatedtype Input
    
    var state: State { get }
    func trigger(_ input: Input)
    
}

//@dynamicMemberLookup
final class AnyViewModel<State, Input>: ViewModel {
    
    private let wrappedObjectWillChange: () -> AnyPublisher<Void, Never>
    private let wrappedState: () -> State
    private let wrappedTrigger: (Input) -> Void
    
    var state: State {
        wrappedState()
    }
    
    func trigger(_ input: Input) {
        wrappedTrigger(input)
    }
    
    init<V: ViewModel>(_ viewModel: V) where V.State == State, V.Input == Input {
        self.wrappedObjectWillChange = { viewModel.objectWillChange.eraseToAnyPublisher() }
        self.wrappedState = { viewModel.state }
        self.wrappedTrigger = viewModel.trigger
    }
}
