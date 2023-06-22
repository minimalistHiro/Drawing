//
//  ViewExtension.swift
//  DrawingMemo
//
//  Created by 金子広樹 on 2023/05/26.
//

import SwiftUI

extension View {
    func asAlert() -> some View {
        modifier(AlertModifier())
    }
}
