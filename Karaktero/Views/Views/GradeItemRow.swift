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
    
    
    var body: some View {
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
    }
}
