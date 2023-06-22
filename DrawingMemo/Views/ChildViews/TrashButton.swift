//
//  TrashButton.swift
//  DrawingMemo
//
//  Created by 金子広樹 on 2023/05/25.
//

import SwiftUI

struct TrashButton: View {
    @ObservedObject var viewModel = ContentViewModel.shared
    
    var body: some View {
        Button {
            viewModel.inputs = .tappedDeleteButton
            viewModel.apply()
        } label: {
            Image(systemName: "trash")
                .resizable()
                .scaledToFit()
                .frame(width: toolbarButtonsSize)
                .foregroundColor(Color("Able"))
        }
        .asAlert()
    }
}
