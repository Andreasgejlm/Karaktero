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

struct GradeListView: View {
    @EnvironmentObject var viewModel: AnyViewModel<GradeListState, GradeListInput>
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: GradeModel.entity(), sortDescriptors: [NSSortDescriptor(key: "timestamp", ascending: true)])
    var grades: FetchedResults<GradeModel>
    @State var showAddNewGrade: Bool = false
    
    init() {
        UITableView.appearance().separatorColor = .clear
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.black)
                .edgesIgnoringSafeArea(.all)
        VStack(alignment: .leading) {
            VStack(spacing: 0) {
                GradeAverageView(showAddGrade: $showAddNewGrade, grades: self.grades.map {$0.self})
                    .frame(height: 280)
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.white)
                        .edgesIgnoringSafeArea(.bottom)
                    List {
                        Spacer()
                        ForEach(self.grades, id: \.objectID) { grade in
                            GradeListItem(grade: grade.self)
                                .environment(\.managedObjectContext, self.managedObjectContext)
                                .frame(height: 60)
                        }
                    }
                }
            }
            .sheet(isPresented: $showAddNewGrade,
                   onDismiss: { UIApplication.shared.endEditing() },
                   content: { AddGradeView(show: self.$showAddNewGrade)
                            .environmentObject(AnyViewModel(AddGradeViewModel()))
                            .environment(\.managedObjectContext, self.managedObjectContext) })
        }
    }
    }
}
