//
//  GradeListView.swift
//  Karaktero
//
//  Created by Andreas Madsen on 02/05/2020.
//  Copyright © 2020 Madsen. All rights reserved.
//

import SwiftUI
import CoreData

struct MainListView: View {
    @State var showAddNewGrade: Bool = false
    @State var showConfirmDelete: Bool = false
    
    init() {
        UITableView.appearance().separatorColor = .clear
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color("TopBackground"))
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading) {
                VStack(spacing: 0) {
//                    GRADE AVERAGE VIEW W. ADD BUTTON
                    GradeAverageView()
                        .frame(height: 210)
//                    GRADE LIST
                    ZStack(alignment: .bottomTrailing) {
                        GradeList()
                        Button(action: {
                            self.showAddNewGrade.toggle()
                        }) {
                            ZStack {
                                Circle()
                                    .fill(Color("AddButtonColor"))
                                Image(systemName: "plus")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(Color("AddSymbolColor"))
                                    .frame(width: 60.0 / 3, height: 60.0 / 3)
                            }
                        }
                        .buttonStyle(BorderlessButtonStyle())
                        .frame(width: 60.0, height: 60.0)
                        .padding(40)
                    }
                }
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        .sheet(isPresented: $showAddNewGrade,
               content: {
                AddGradeView(show: self.$showAddNewGrade)
                    .environmentObject(AnyViewModel(AddGradeViewModel()))
        })
    }
}
