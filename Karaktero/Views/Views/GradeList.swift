//
//  GradeList.swift
//  Karaktero
//
//  Created by Andreas Madsen on 18/05/2020.
//  Copyright © 2020 Madsen. All rights reserved.
//

import SwiftUI

struct GradeList: View {
    @EnvironmentObject var vm: AnyViewModel<GradeListViewState, GradeListViewInput>
    let grades: [Grade]
    
    init(grades: [Grade]) {
        self.grades = grades
        UITableView.appearance().separatorColor = .clear
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color("ListBackground"))
                .edgesIgnoringSafeArea(.bottom)
            List {
                Spacer()
                ForEach(grades, id: \.objectID) { grade in
                    GradeItem()
                        .environmentObject(AnyViewModel(GradeItemViewModel(grade: grade)))
//                    GradeListItem(grade: grade.self)
//                        .environment(\.managedObjectContext, self.managedObjectContext)
//                        .frame(height: 60)
                }
            }
        }
    }
}
