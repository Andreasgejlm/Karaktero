//
//  GradeListView.swift
//  Karaktero
//
//  Created by Andreas Madsen on 02/05/2020.
//  Copyright © 2020 Madsen. All rights reserved.
//

import SwiftUI
import CoreData

struct GradeListState {
//    var grades: [Grade]
}

enum GradeListInput {
    case fetch
//    case newGrade(Grade)
//    case assignContext(NSManagedObjectContext)
}

struct MainListView: View {
    @EnvironmentObject var vm: AnyViewModel<MainListViewState, MainListViewInput>
    @State var showAddNewGrade: Bool = false    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.black)
                .edgesIgnoringSafeArea(.all)
        VStack(alignment: .leading) {
            VStack(spacing: 0) {
                GradeAverageView(showAddGrade: $showAddNewGrade)
                .environmentObject(AnyViewModel(GradeAverageViewModel()))
                    .frame(height: 210)
                GradeList(grades: vm.state.grades)
                    .environmentObject(AnyViewModel(GradeListViewModel()))
            }
            .sheet(isPresented: $showAddNewGrade,
                   onDismiss: {
                    UIApplication.shared.endEditing()
                    self.vm.trigger(.fetch)
            },
                   content: {
                    EmptyView()
                    AddGradeView(show: self.$showAddNewGrade)
                        .environmentObject(AnyViewModel(AddGradeViewModel()))
            })
        }
    }
    }
}
