//
//  GradeAverageView.swift
//  Karaktero
//
//  Created by Andreas Madsen on 13/05/2020.
//  Copyright © 2020 Madsen. All rights reserved.
//

import SwiftUI

struct GradeAverageView: View {
    @EnvironmentObject var vm: AnyViewModel<GradeAverageViewState, GradeAverageViewInput>
    @Binding var showAddGrade: Bool
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Rectangle()
                .fill(Color("TopBackground"))
                .edgesIgnoringSafeArea(.top)
            VStack (alignment: .leading) {
                Text(NSLocalizedString("summary", comment: ""))
                    .font(.system(size: 34, weight: .bold, design: .default))
                    .foregroundColor(Color("TopTextColor"))
                    .padding(.top, 10)
                HStack {
                    Image(systemName: "checkmark.seal")
                        .resizable()
                        .foregroundColor(Color("TopTextColor"))
                        .frame(width: 34, height: 34)
                    VStack(alignment: .leading, spacing: 0) {
                        Text(vm.state.averageString)
                            .font(.system(size: 30, weight: .bold, design: .rounded))
                            .foregroundColor(Color("TopTextColor"))
                        Text(NSLocalizedString("weighted-average", comment: ""))
                            .font(.footnote)
                            .foregroundColor(Color("TopTextColor"))
                    }
                    Spacer()
                }
                HStack {
                    Image(systemName: "clock")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color("TopTextColor"))
                    VStack(alignment: .leading, spacing: 0) {
                        Text(String(vm.state.sumECTSString))
                            .font(.system(size: 30, weight: .bold, design: .rounded))
                            .foregroundColor(Color("TopTextColor"))
                        Text("ECTS")
                            .font(.footnote)
                            .foregroundColor(Color("TopTextColor"))
                    }
                }
                Spacer()
            }
            .padding(.leading)
            Button(action: {
                self.showAddGrade.toggle()
            }) {
                ZStack {
                    Circle()
                        .fill(Color("AddGradeTertiaryColor"))
                    Image(systemName: "plus")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color("AddSymbolColor"))
                        .frame(width: 60.0 / 3, height: 60.0 / 3)
                }
            }
            .buttonStyle(BorderlessButtonStyle())
            .frame(width: 60.0, height: 60.0)
            .padding()
        }
//        .frame(height: scroll >= 0.0 ? 200 : 100)
    }
}
