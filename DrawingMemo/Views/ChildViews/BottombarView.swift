//
//  BottombarView.swift
//  DrawingMemo
//
//  Created by 金子広樹 on 2023/05/27.
//

import SwiftUI

struct BottombarView: View {
    @ObservedObject var viewModel = ContentViewModel.shared
    @State private var bottombarRect: CGRect = .zero
    @State private var isShowSelectColorWindow: Bool = false    // 色選択ウィンドウの表示有無
    @State private var isShowSelectPenWindow: Bool = false      // ペン選択ウィンドウの表示有無
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                HStack(spacing: 10) {
                    Spacer()
                    
                    Button {
                        viewModel.bottomTool = .tappedPen
                        isShowSelectPenWindow = true
                    } label: {
                        Circle()
                            .foregroundColor(focusCheck(.tappedPen))
                            .frame(width: bottomOutsideCircleButtonsSize)
                            .overlay {
                                Image(systemName: {
                                    if viewModel.inkType == .pencil {
                                        return "pencil"
                                    } else if viewModel.inkType == .pen {
                                        return "pencil.tip"
                                    } else {
                                        return "highlighter"
                                    }
                                }())
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: bottomInsideCircleButtonsSize)
                                    .foregroundColor(able)
                            }
                    }
                    
                    Spacer()
                    
                    Button {
                        viewModel.bottomTool = .tappedEraser
                    } label: {
                        Circle()
                            .foregroundColor(focusCheck(.tappedEraser))
                            .frame(width: bottomOutsideCircleButtonsSize)
                            .overlay {
                                Image(systemName: "eraser")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: bottomEraserButtonsSize)
                                    .foregroundColor(able)
                            }
                    }
                    
                    Spacer()
                    
                    Button {
                        isShowSelectColorWindow = true
                    } label: {
                        Image(systemName: "circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: bottomInsideCircleButtonsSize)
                            .foregroundColor(viewModel.selectedColor.color)
                    }
                    
                    Spacer()
                    
                    Slider(value: $viewModel.lineWidth, in: minLineWidth...maxLineWidth)
                        .frame(maxWidth: sliderMaxSize)
                    
                    Spacer()
                }
                RoundedRectangle(cornerSize: CGSize(width: 30, height: 30))
                    .stroke(able, lineWidth: 3)
                    .background(disable)
                    .padding(.horizontal)
                    .frame(width: bottombarRect.width, height: bottombarRect.height)
                    .overlay {
                        PenSelectView(isShow: $isShowSelectPenWindow)
                    }
                    .offset(y: isShowSelectPenWindow ? 0 : UIScreen.main.bounds.height / 2 )
                    .animation(Animation.default, value: isShowSelectPenWindow)
                RoundedRectangle(cornerSize: CGSize(width: 30, height: 30))
                    .stroke(able, lineWidth: 3)
                    .background(disable)
                    .padding(.horizontal)
                    .frame(width: bottombarRect.width, height: bottombarRect.height)
                    .overlay {
                        ColorSelectView(isShow: $isShowSelectColorWindow)
                    }
                    .offset(y: isShowSelectColorWindow ? 0 : UIScreen.main.bounds.height / 2 )
                    .animation(Animation.default, value: isShowSelectColorWindow)
            }
            .onAppear {
                bottombarRect = geometry.frame(in: .local)
            }
        }
    }
    
    ///　選択されたボタン（ペンもしくは消しゴム）を強調する。
    /// - Parameters:
    ///   - inputs: 選択されたボタン（ペンもしくは消しゴム）
    /// - Returns: 選択されたボタン（ペンもしくは消しゴム）と一致したならハイライト、それ以外なら白（ダークモードの場合は逆）。
    private func focusCheck(_ tool: ContentViewModel.BottomTool) -> Color {
        if viewModel.bottomTool == tool {
            return highlight
        } else {
            return disable
        }
    }
}
