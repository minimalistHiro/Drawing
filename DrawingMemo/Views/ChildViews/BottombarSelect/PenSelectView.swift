//
//  PenSelectView.swift
//  DrawingMemo
//
//  Created by 金子広樹 on 2023/06/06.
//

import SwiftUI
import PencilKit

struct PenSelectView: View {
    @ObservedObject var viewModel = ContentViewModel.shared
    @Binding var isShow: Bool
    
    var body: some View {
        HStack {
            Spacer()
            
            Button {
                viewModel.inkType = .pencil
                isShow = false
            } label: {
                Circle()
                    .foregroundColor(focusCheck(.pencil))
                    .frame(width: bottomOutsideCircleButtonsSize)
                    .overlay {
                        Image(systemName: "pencil")
                            .resizable()
                            .scaledToFit()
                            .frame(width: bottomInsideCircleButtonsSize)
                            .foregroundColor(able)
                    }
            }
            
            Spacer()
            
            Button {
                viewModel.inkType = .pen
                isShow = false
            } label: {
                Circle()
                    .foregroundColor(focusCheck(.pen))
                    .frame(width: bottomOutsideCircleButtonsSize)
                    .overlay {
                        Image(systemName: "pencil.tip")
                            .resizable()
                            .scaledToFit()
                            .frame(width: bottomInsideCircleButtonsSize)
                            .foregroundColor(able)
                    }
            }
            
            Spacer()
            
            Button {
                viewModel.inkType = .marker
                isShow = false
            } label: {
                Circle()
                    .foregroundColor(focusCheck(.marker))
                    .frame(width: bottomOutsideCircleButtonsSize)
                    .overlay {
                        Image(systemName: "highlighter")
                            .resizable()
                            .scaledToFit()
                            .frame(width: bottomInsideCircleButtonsSize)
                            .foregroundColor(able)
                    }
            }
            
            Spacer()
        }
    }
    
    ///　選択されたペンとペン選択ボタンの一致、不一致を確認。一致したら、ボタンを強調する。
    /// - Parameters:
    ///   - inkType: 選択されたペンの種類
    /// - Returns: 選択されたペンがペン選択ボタンと一致したならハイライト、それ以外なら白（ダークモードの場合は逆）。
    private func focusCheck(_ inkType: PKInkingTool.InkType) -> Color {
        if viewModel.inkType == inkType {
            return highlight
        } else {
            return disable
        }
    }
}
