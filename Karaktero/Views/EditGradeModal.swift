//
//  EditGradeModal.swift
//  Karaktero
//
//  Created by Andreas Madsen on 17/05/2020.
//  Copyright © 2020 Madsen. All rights reserved.
//

import SwiftUI
import Introspect

struct EditGradeModal: View {
    @Binding var show: Bool
    @Binding var grade: GradeModel
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
    
    init(show: Binding<Bool>, grade: Binding<GradeModel>) {
        self._show = show
        self._grade = grade
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color("EditGradeBackground"))
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    UIApplication.shared.endEditing()
                }
            VStack(alignment: .leading, spacing: 25) {
                Text(NSLocalizedString("edit-grade", comment: "Edit grade"))
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
                                self.title = self.grade.courseTitle ?? " "
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
                                self.ectsString = String(self.grade.ects)
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
                                            .fill(Color(self.gradeString == gradeString ? "GradeSelectedFill" :"EditGradeBackground"))
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
                        .onAppear {
                            self.gradeString = String(self.grade.grade)
                        }
                        Text(NSLocalizedString("select-grade", comment: "Select grade"))
                            .font(.footnote)
                            .foregroundColor(Color("TopTextColor"))
                    }
                    
                }
                HStack {
                    Spacer()
                    Button(action: { self.editGrade() }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color("EditGradeBackground"))
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color("TopTextColor"))
                            Text(NSLocalizedString("confirm", comment: ""))
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
    func editGrade() {
        grade.courseTitle = title
        grade.ects = Int16(ectsString) ?? 0
        grade.grade = Int16(gradeString) ?? 0
        UIApplication.shared.endEditing()
        show.toggle()
    }
}
