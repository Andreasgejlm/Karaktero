//
//  GradeAverageView.swift
//  Karaktero
//
//  Created by Andreas Madsen on 13/05/2020.
//  Copyright © 2020 Madsen. All rights reserved.
//

import SwiftUI

struct GradeAverageView: View {
    @FetchRequest(entity: Grade.entity(), sortDescriptors: [NSSortDescriptor(key: "timestamp", ascending: true)]) var grades: FetchedResults<Grade>
    var sumEcts: Int16 { grades.map{$0.ects}.reduce(0, +) }
    var sumEctsString: String {
        return String(sumEcts)
    }
    var averageString: String {
        let sumWeights = grades.map { $0.ects * $0.grade }.reduce(0, +)
        let avg: Double? = sumEcts > 0 ? Double( sumWeights ) / Double( sumEcts ) : nil
        if let avg = avg {
            return String(format: "%.1f", avg)
        } else {
            return " - "
        }
    }
    
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
                        .padding(.trailing)
                    VStack(alignment: .leading, spacing: 0) {
                        Text(averageString)
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
                        .padding(.trailing)
                    VStack(alignment: .leading, spacing: 0) {
                        Text(String(sumEctsString))
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
        }
//        .frame(height: scroll >= 0.0 ? 200 : 100)
    }
}
