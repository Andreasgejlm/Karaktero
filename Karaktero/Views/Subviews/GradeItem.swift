//
//  GradeItem.swift
//  Karaktero
//
//  Created by Andreas Madsen on 18/05/2020.
//  Copyright © 2020 Madsen. All rights reserved.
//

import SwiftUI

struct GradeItem: View {
    @ObservedObject var grade: Grade
    @State var showEditGrade: Bool = false
    @State var showDeleteConfirm: Bool = false
    @State var currentPosition: CGFloat = 0.0
    @State var offsetPosition: CGFloat = 0.0
    @State var itemOpacity: Double = 1.0
    var offsetWidth: CGFloat { 2 * itemHeight + 15 }
    let itemHeight: CGFloat = 60.0
    
    var body: some View {
        ZStack (alignment: .trailing) {
            ButtonRow(edit: $showEditGrade,
                      delete: $showDeleteConfirm,
                      buttonDimension: itemHeight)
                .sheet(isPresented: self.$showEditGrade,
                    onDismiss: {
                        self.currentPosition = 0.0
                        self.offsetPosition = 0.0
                    },
                    content: {
                        EditGradeModal(show: self.$showEditGrade)
                            .environmentObject(AnyViewModel(EditGradeViewModel(grade: self.grade)))
                    })
            GradeItemRow(grade: grade)
                .frame(height: itemHeight)
                .offset(x: self.offsetPosition, y: 0)
                .animation(.easeInOut)
                .gesture(
                    DragGesture(minimumDistance: 30, coordinateSpace: .local)
                    .onEnded{ value in
                        if value.translation.width < 0 {
                            self.offsetPosition = -self.offsetWidth
                        } else {
                            self.offsetPosition = 0.0
                        }
                        self.currentPosition = self.offsetPosition
                    }
                    .onChanged { value in
                        if self.offsetPosition < 200 && self.offsetPosition > -200 {
                            self.offsetPosition = self.currentPosition + value.translation.width
                        }
                    })
        }
        .opacity(itemOpacity)
        .animation(.easeInOut)
        .actionSheet(isPresented: $showDeleteConfirm, content: {
            ActionSheet(title: Text(NSLocalizedString("delete-grade", comment: "")),
                        message: Text(NSLocalizedString("sure-delete", comment: "")),
                        buttons: [
                        .default(Text(NSLocalizedString("confirm", comment: ""))) {
                            CoreDataManager.shared.deleteGrade(grade: self.grade)
                            self.itemOpacity = 0
                            },
                        .cancel()
                ])
            })
    }
}
