//
//  ShareButton.swift
//  DrawingMemo
//
//  Created by 金子広樹 on 2023/05/25.
//

import SwiftUI

struct ShareButton: View {
    @ObservedObject var viewModel = ContentViewModel.shared
    
    var body: some View {
        Button {
            viewModel.inputs = .tappedCaptureButton
            viewModel.apply()
        } label: {
            Image(systemName: "square.and.arrow.up")
                .resizable()
                .scaledToFit()
                .frame(width: toolbarButtonsSize)
                .foregroundColor(Color("Able"))
        }
        .asAlert()
    }
}
