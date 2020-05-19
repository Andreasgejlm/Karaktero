//
//  ButtonRow.swift
//  Karaktero
//
//  Created by Andreas Madsen on 18/05/2020.
//  Copyright © 2020 Madsen. All rights reserved.
//

import SwiftUI

struct ButtonRow: View {
    @Binding var edit: Bool
    @Binding var delete: Bool
    let buttonDimension: CGFloat
    
    var body: some View {
        HStack {
            Button(action: { self.edit.toggle() }) {
                ZStack {
                    Circle()
                        .stroke(Color("EditButtonStrokeColor"), lineWidth: 1)
                    Image(systemName: "pencil")
                        .resizable()
                        .frame(width: buttonDimension/3.0, height: buttonDimension/3.0)
                        .foregroundColor(Color("EditButtonStrokeColor"))
                }
                .frame(width: buttonDimension - 2, height: buttonDimension - 2)
            }
            .buttonStyle(BorderlessButtonStyle())
            Button(action: { self.delete.toggle() }) {
                ZStack {
                    Circle()
                        .fill(Color("DeleteColor"))
                    Image(systemName: "trash")
                        .resizable()
                        .frame(width: buttonDimension/3.0, height: buttonDimension/3.0)
                        .foregroundColor(Color("DeleteSymbolColor"))
                }
                .frame(width: buttonDimension - 1, height: buttonDimension - 1)
            }
            .buttonStyle(BorderlessButtonStyle())
        }
    }
}
