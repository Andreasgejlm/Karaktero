//
//  MainListView.swift
//  Karaktero-Ipad
//
//  Created by Andreas Madsen on 24/05/2020.
//  Copyright © 2020 Madsen. All rights reserved.
//

import SwiftUI

struct MainListView: View {
    @State var showAddNewGrade: Bool = false
    @State var showConfirmDelete: Bool = false
    @Environment(\.horizontalSizeClass) var sc
    
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color("TopBackground"))
                .edgesIgnoringSafeArea(.all)
            .sheet(isPresented: $showAddNewGrade, content: {
                AddGradeView(show: self.$showAddNewGrade)
                    .environmentObject(AnyViewModel(AddGradeViewModel()))
            })
            if sc == .regular {
                HStack {
                    VStack {
                //           GRADE AVERAGE VIEW
                        GradeAverageView()
                            .padding()
                //           EDIT GRADE VIEW
                    }
                    //         GRADE LIST VIEW
                    Spacer()
                    ZStack(alignment: .bottomTrailing) {
                        GradeList()
                            .edgesIgnoringSafeArea(.bottom)
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
                    .padding()
                }
            }
            else {
                VStack {
                    GradeAverageView()
                        .frame(height: 200)
                        .padding()
                    ZStack(alignment: .bottomTrailing) {
                        GradeList()
                            .edgesIgnoringSafeArea(.bottom)
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
        }
    }
}

struct MainListView_Previews: PreviewProvider {
    static var previews: some View {
        MainListView()
    }
}
