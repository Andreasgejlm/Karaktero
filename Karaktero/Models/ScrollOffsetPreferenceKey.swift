//
//  ScrollOffsetPreferenceKey.swift
//  Karaktero
//
//  Created by Andreas Madsen on 15/05/2020.
//  Copyright © 2020 Madsen. All rights reserved.
//

import Foundation
import SwiftUI

struct ScrollOffsetPreferenceKey: PreferenceKey {
    typealias Value = [CGFloat]
    
    static var defaultValue: [CGFloat] = [0]
    
    static func reduce(value: inout [CGFloat], nextValue: () -> [CGFloat]) {
        value.append(contentsOf: nextValue())
    }
}


extension CGFloat {
    func bounce(inRange range: ClosedRange<CGFloat>) -> CGFloat {
        let increasing = Int(self / (range.upperBound - range.lowerBound)) % 2 == 0
        let newWidth = abs(self).truncatingRemainder(dividingBy: range.upperBound - range.lowerBound)
        return increasing ? range.lowerBound + newWidth : range.upperBound - newWidth
    }
}

extension View {
    func expandHorizontally() -> some View {
        frame(maxWidth: .infinity)
    }
}
