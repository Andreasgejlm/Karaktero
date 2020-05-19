//
//  GradeListItem.swift
//  Karaktero
//
//  Created by Andreas Madsen on 15/05/2020.
//  Copyright © 2020 Madsen. All rights reserved.
//

import SwiftUI

struct GradeListItem: View {
    @State var grade: Grade
    @Environment(\.managedObjectContext) var managedObjectContext
    @State var offsetPosition: CGFloat = 0.0
    @State var currentPosition: CGFloat = .zero
    @State var showConfirmDelete: Bool = false
    @State var showEditGrade: Bool = false
    @State var itemOpacity: Double = 1
    let height: CGFloat = 60.0
    var offsetWidth: CGFloat { 2 * height + 15 }
    var gradeString: String {
        switch grade.grade {
            case 2: return "02"
            case 0: return "00"
            default: return String(grade.grade)
        }
    }
    
    var body: some View {
        ZStack (alignment: .trailing) {
            HStack {
                Button(action: { self.showEditGrade.toggle() }) {
                    ZStack {
                        Circle()
                            .stroke(Color("EditButtonStrokeColor"), lineWidth: 1)
                        Image(systemName: "pencil")
                            .resizable()
                            .frame(width: height/3.0, height: height/3.0)
                            .foregroundColor(Color("EditButtonStrokeColor"))
                    }
                .frame(width: height - 2, height: height - 2)
                }
                .buttonStyle(BorderlessButtonStyle())
                Button(action: { self.showConfirmDelete.toggle() }) {
                    ZStack {
                        Circle()
                            .fill(Color("DeleteColor"))
                        Image(systemName: "trash")
                            .resizable()
                            .frame(width: height/3.0, height: height/3.0)
                            .foregroundColor(Color("DeleteSymbolColor"))
                    }
                    .frame(width: height - 1, height: height - 1)
                }
                .buttonStyle(BorderlessButtonStyle())
            }
            .sheet(isPresented: self.$showEditGrade,
                   onDismiss: {
                        self.currentPosition = 0.0
                        self.offsetPosition = 0.0
                        self.editGrade()
                    },
                   content: {
                        EditGradeModal(show: self.$showEditGrade, grade: self.$grade)
                    }
            )
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color("ListItemBackground"))
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color("ListItemStroke"))
                    HStack {
                        VStack(alignment: .leading) {
                            Text(grade.courseTitle ?? "--")
                                .lineLimit(2)
                                .truncationMode(.tail)
                                .font(.headline)
                                .foregroundColor(.primary)
                        }
                        Spacer()
                        VStack(alignment: .leading) {
                            Text(String(grade.ects))
                                .font(.body)
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)
                            Text(NSLocalizedString("ects", comment: "ECTS"))
                                .font(.footnote)
                                .foregroundColor(.secondary)
                        }
                        VStack(alignment: .leading) {
                            Text(gradeString)
                                .font(.body)
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)
                            Text(NSLocalizedString("grade", comment: "Grade"))
                                .font(.footnote)
                                .foregroundColor(.secondary)
                        }
                    }
                .padding([.leading, .trailing], 30)
            }
            .frame(height: height)
            .offset(x:self.offsetPosition, y: 0)
            .animation(.easeInOut)
            .gesture(DragGesture(minimumDistance: 30, coordinateSpace: .local)
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
                }
            )
        }
    .opacity(itemOpacity)
    .actionSheet(isPresented: $showConfirmDelete, content: {
        ActionSheet(title: Text(NSLocalizedString("delete-grade", comment: "")),
                    message: Text(NSLocalizedString("sure-delete", comment: "")),
                    buttons: [
                    .default(Text(NSLocalizedString("confirm", comment: ""))) {
                        self.itemOpacity = 0
                        self.deleteGrade()
                        },
                    .cancel()
            ])
        })
    }
    
    func editGrade() {
        let temp2 = Grade(context: managedObjectContext)
        temp2.timestamp = grade.timestamp
        temp2.courseTitle = grade.courseTitle
        temp2.ects = grade.ects
        temp2.grade = grade.grade
        managedObjectContext.delete(grade)
        do {
            try managedObjectContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteGrade() {
        managedObjectContext.delete(grade)
        do {
            try self.managedObjectContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
