//
//  File.swift
//  DrawingMemo
//
//  Created by 金子広樹 on 2023/05/08.
//

import SwiftUI

extension String {
    func toColor(_ name: String) -> Color {
        Color(name)
    }
}

extension Double {
    func toCGPoint(x: Double, y:Double) -> CGPoint {
        CGPoint(x: x, y: y)
    }
}
