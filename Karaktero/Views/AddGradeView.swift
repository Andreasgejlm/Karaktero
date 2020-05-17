//
//  AddGradeListItem.swift
//  Karaktero
//
//  Created by Andreas Madsen on 04/05/2020.
//  Copyright © 2020 Madsen. All rights reserved.
//

import SwiftUI
import CoreData
import Introspect

struct AddGradeViewState {
//    var newGrade: Grade
}

enum AddGradeViewInput {
//    case setNewGrade(Grade)
//    case assignContext(NSManagedObjectContext)
}

struct AddGradeView: View {
    @EnvironmentObject var viewModel: AnyViewModel<AddGradeViewState, AddGradeViewInput>
    @Environment(\.managedObjectContext) var managedObjectContext
    @Binding var show: Bool
    @State var title: String = " "
    @State var ectsString: String = " "
    @State var gradeString: String = "4"
    @State var gradeOptions: [String] = ["-3", "00", "02", "4", "7", "10", "12"]
    var titleValid: Bool {
        title.count > 0
    }
    var ectsValid: Bool {
        if let _ = Int16(ectsString) {
            return true
        } else {
            return false
        }
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color("AddGradeBackground"))
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    UIApplication.shared.endEditing()
                }
            VStack(alignment: .leading, spacing: 25) {
                Text(NSLocalizedString("add-new-grade", comment: "Add grade"))
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color("TopTextColor"))
                VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: 0) {
                        TextField("", text: $title)
                            .autocapitalization(.sentences)
                            .foregroundColor(Color("TopTextColor"))
                            .accentColor(Color("TopTextColor"))
                            .font(.title)
                            .onAppear {
                                self.title = ""
                            }
                            .introspectTextField{ textField in
                                textField.becomeFirstResponder()
                                textField.textColor = UIColor(named: "TopTextColor")
                            }
                        Divider()
                            .background(titleValid ? Color("TopTextColor") : Color("InvalidColor"))
                        Text(NSLocalizedString("input-course-title", comment: "Input course title"))
                            .font(.footnote)
                            .foregroundColor(Color("TopTextColor"))
                        
                    }
                    VStack(alignment: .leading, spacing: 0) {
                        TextField("", text: $ectsString)
                            .keyboardType(.decimalPad)
                            .foregroundColor(Color("TopTextColor"))
                            .accentColor(Color("TopTextColor"))
                            .font(.title)
                            .onAppear {
                                self.ectsString = ""
                            }
                        Divider()
                            .background(ectsValid ? Color("TopTextColor") : Color("InvalidColor"))
                        Text(NSLocalizedString("input-ects-points", comment: "Input ECTS"))
                            .font(.footnote)
                            .foregroundColor(Color("TopTextColor"))
                        
                    }
                    .frame(width: 120)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            ForEach(self.gradeOptions, id: \.self) { gradeString in
                                Button(action: {
                                    self.gradeString = gradeString
                                }) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 15)
                                            .fill(Color(self.gradeString == gradeString ? "GradeSelectedFill" :"AddGradeBackground"))
                                            .animation(.interactiveSpring())
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(Color(self.gradeString == gradeString ? "GradeSelectedStroke" :"GradeNotSelectedStroke"))
                                            .animation(.interactiveSpring())
                                        Text(gradeString)
                                            .font(.headline)
                                            .foregroundColor(Color(self.gradeString == gradeString ? "GradeSelectedStroke" :"GradeNotSelectedStroke"))
                                    }
                                    .frame(height: 50)
                                }
                            }
                        }
                        Text(NSLocalizedString("select-grade", comment: "Select grade"))
                            .font(.footnote)
                            .foregroundColor(Color("TopTextColor"))
                    }
                    
                }
                HStack {
                    Spacer()
                    Button(action: { self.addGrade() }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color("AddGradeBackground"))
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color("TopTextColor"))
                            Text(NSLocalizedString("add", comment: ""))
                                .font(.body)
                                .fontWeight(.semibold)
                                .foregroundColor(Color("TopTextColor"))
                        }
                    }
                    .disabled(!titleValid || !ectsValid)
                    .buttonStyle(BorderlessButtonStyle())
                    .frame(width: 100, height: 40)
                    .padding(.trailing)
                }
                Spacer()
            }
            .padding(.top, 35)
            .padding([.leading, .trailing, .bottom], 20)
        }
    }
    
    func addGrade() {
        let newGrade = GradeModel(context: self.managedObjectContext)
        newGrade.courseTitle = title
        newGrade.ects = Int16(ectsString) ?? 0
        newGrade.grade = Int16(gradeString) ?? 0
        newGrade.timestamp = Date().timeIntervalSince1970
        try? managedObjectContext.save()
        UIApplication.shared.endEditing()
        self.show.toggle()
    }
}

struct AddGradeView_Previews: PreviewProvider {
    static var previews: some View {
        Color.clear.sheet(isPresented: .constant(true), content: { AddGradeView(show: .constant(true)) })
    }
}

// extension for keyboard to dismiss
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}