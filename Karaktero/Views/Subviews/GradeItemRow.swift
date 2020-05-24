//
//  GradeItemRow.swift
//  Karaktero
//
//  Created by Andreas Madsen on 18/05/2020.
//  Copyright © 2020 Madsen. All rights reserved.
//

import SwiftUI

struct GradeItemRow: View {
    let grade: Grade
    var gradeString: String {
        switch grade.grade {
            case 2: return "02"
            case 0: return "00"
            default: return String(grade.grade)
        }
    }
    
    let itemHeight: CGFloat = 60.0
    @State var currentPosition: CGFloat = 0.0
    @State var offsetPosition: CGFloat = 0.0
    var offsetWidth: CGFloat { 2 * itemHeight + 15 }
    
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(Color("ListItemBackground"))
//            RoundedRectangle(cornerRadius: 30)
//                .stroke(Color("ListItemStroke"))
                HStack {
                    VStack(alignment: .leading) {
                        Text(grade.courseTitle ?? "--")
                            .lineLimit(2)
                            .truncationMode(.tail)
                            .font(.headline)
                            .foregroundColor(Color("TopTextColor"))
                    }
                    Spacer()
                    VStack(alignment: .leading) {
                        Text(String(grade.ects))
                            .font(.body)
                            .fontWeight(.semibold)
                            .foregroundColor(Color("TopTextColor"))
                        Text(NSLocalizedString("ects", comment: "ECTS"))
                            .font(.footnote)
                            .foregroundColor(Color("SecondaryTopTextColor"))
                    }
                    VStack(alignment: .leading) {
                        Text(gradeString)
                            .font(.body)
                            .fontWeight(.semibold)
                            .foregroundColor(Color("TopTextColor"))
                        Text(NSLocalizedString("grade", comment: "Grade"))
                            .font(.footnote)
                            .foregroundColor(Color("SecondaryTopTextColor"))
                    }
                }
            .padding([.leading, .trailing], 30)
        }
    }
}
