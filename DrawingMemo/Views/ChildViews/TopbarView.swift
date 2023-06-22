//
//  TopbarView.swift
//  DrawingMemo
//
//  Created by 金子広樹 on 2023/05/27.
//

import SwiftUI
import PencilKit

struct TopbarView: View {
    @ObservedObject var viewModel = ContentViewModel.shared
    @State var capture: UIImage?
    
    var body: some View {
        HStack {
            Button {
                viewModel.inputs = .tappedDeleteButton
                viewModel.apply()
            } label: {
                Image(systemName: "trash")
                    .resizable()
                    .scaledToFit()
                    .frame(width: toolbarButtonsSize)
                    .foregroundColor(able)
            }
            .asAlert()
            
            Spacer()
            
            Button {
                capture = viewModel.capture()
                viewModel.isShowActivity = true
            } label: {
                Image(systemName: "square.and.arrow.up")
                    .resizable()
                    .scaledToFit()
                    .frame(width: toolbarButtonsSize)
                    .foregroundColor(able)
            }
            .asAlert()
            .sheet(isPresented: $viewModel.isShowActivity) {
                if let capture = capture {
                    ActivityView(shareItems: [capture])
                }
            }
        }
        .padding(.horizontal)
    }
}
