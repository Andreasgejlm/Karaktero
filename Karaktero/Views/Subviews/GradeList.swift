//
//  GradeList.swift
//  Karaktero
//
//  Created by Andreas Madsen on 18/05/2020.
//  Copyright © 2020 Madsen. All rights reserved.
//

import SwiftUI

struct GradeList: View {
    @FetchRequest(entity: Grade.entity(), sortDescriptors: [NSSortDescriptor(key: "timestamp", ascending: true)]) var grades: FetchedResults<Grade>
    
    init() {
        UITableView.appearance().separatorColor = .clear
        UITableView.appearance().backgroundColor = UIColor(named: "ListBackground")
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack {
            if grades.count > 0 {
                List {
                    Color.clear
                        .frame(height: 10)
                        ForEach(grades, id: \.objectID) { grade in
                            ZStack(alignment: .trailing) {
                                GradeItem(grade: grade)
                            }
                        }
                    }.cornerRadius(25)
                .environment(\.defaultMinListRowHeight, 5)
            } else {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color("ListBackground"))
                Text(NSLocalizedString("add-grades-by", comment: ""))
                    .foregroundColor(Color("TopTextColor"))
            }
        }
    }
}
