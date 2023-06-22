//
//  ColorSelectView.swift
//  DrawingMemo
//
//  Created by 金子広樹 on 2023/06/06.
//

import SwiftUI

struct ColorSelectView: View {
    @ObservedObject var viewModel = ContentViewModel.shared
    @Binding var isShow: Bool
    
    var body: some View {
        HStack {
            Spacer()
            
            Button {
                viewModel.selectedColor = .black
                isShow = false
            } label: {
                Circle()
                    .foregroundColor(focusCheck(.black))
                    .frame(width: bottomOutsideCircleButtonsSize)
                    .overlay {
                        Image(systemName: "circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: bottomInsideCircleButtonsSize)
                            .foregroundColor(DrawColor.black.color)
                    }
            }
            
            Spacer()
            
            Button {
                viewModel.selectedColor = .red
                isShow = false
            } label: {
                Circle()
                    .foregroundColor(focusCheck(.red))
                    .frame(width: bottomOutsideCircleButtonsSize)
                    .overlay {
                        Image(systemName: "circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: bottomInsideCircleButtonsSize)
                            .foregroundColor(DrawColor.red.color)
                    }
            }
            
            Spacer()
            
            Button {
                viewModel.selectedColor = .blue
                isShow = false
            } label: {
                Circle()
                    .foregroundColor(focusCheck(.blue))
                    .frame(width: bottomOutsideCircleButtonsSize)
                    .overlay {
                        Image(systemName: "circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: bottomInsideCircleButtonsSize)
                            .foregroundColor(DrawColor.blue.color)
                    }
            }
            
            Spacer()
        }
    }
    
    ///　選択された色と色選択ボタンの色の一致、不一致を確認。一致したら、ボタンを強調する。
    /// - Parameters:
    ///   - color: 色選択ボタンの色
    /// - Returns: 選択された色が色選択ボタンの色と一致したならハイライト、それ以外なら白（ダークモードの場合は逆）。
    private func focusCheck(_ color: DrawColor) -> Color {
        if viewModel.selectedColor == color {
            return highlight
        } else {
            return disable
        }
    }
}
