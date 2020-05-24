//
//  GradeItem.swift
//  Karaktero-Ipad
//
//  Created by Andreas Madsen on 24/05/2020.
//  Copyright © 2020 Madsen. All rights reserved.
//

import SwiftUI

struct GradeItemvewve: View {
    @ObservedObject var grade: Grade
    @State var itemOpacity: Double = 1.0
    let itemHeight: CGFloat = 60.0
    
    var body: some View {
        GradeItemRow(grade: grade)
            .frame(height: itemHeight)
            .opacity(itemOpacity)
            .animation(.easeInOut)
    }
}

