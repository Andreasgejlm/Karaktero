//
//  GradeAverageView.swift
//  Karaktero
//
//  Created by Andreas Madsen on 13/05/2020.
//  Copyright © 2020 Madsen. All rights reserved.
//

import SwiftUI

struct GradeAverageView: View {
    @Binding var showAddGrade: Bool
    let grades: [GradeModel]
    var sumEcts: Int16 {
        grades.map{$0.ects}.reduce(0, +)
    }
    var average: String {
        let sumWeights = grades.map { $0.ects * $0.grade }.reduce(0, +)
        let avg: Double? = sumEcts > 0 ? Double( sumWeights ) / Double( sumEcts ) : nil
        if let avg = avg { return String(format: "%.1f", avg) } else { return " - " }
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color("TopBackground"))
                .edgesIgnoringSafeArea(.top)
        VStack (alignment: .leading) {
            Text(NSLocalizedString("summary", comment: ""))
                .font(.system(size: 34, weight: .bold, design: .default))
                .foregroundColor(Color("TopTextColor"))
                .padding(.top, 50)
                HStack {
                    Image(systemName: "checkmark.seal")
                        .resizable()
                        .foregroundColor(Color("TopTextColor"))
                        .frame(width: 34, height: 34)
                    VStack(alignment: .leading, spacing: 0) {
                        Text(average)
                            .font(.system(size: 34, weight: .bold, design: .rounded))
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
                        Text(String(sumEcts))
                            .font(.system(size: 34, weight: .bold, design: .rounded))
                            .foregroundColor(Color("TopTextColor"))
                        Text("ECTS")
                            .font(.footnote)
                            .foregroundColor(Color("TopTextColor"))
                    }
                    Spacer()
                    Button(action: {
                        self.showAddGrade.toggle()
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
//                    .buttonStyle(BorderlessButtonStyle())
                    .frame(width: 60.0, height: 60.0)
                }
                Spacer()
            }
            .padding([.leading, .trailing])
        }
//        .frame(height: scroll >= 0.0 ? 200 : 100)
    }
}
