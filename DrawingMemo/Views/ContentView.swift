//
//  ContentView.swift
//  DrawingMemo
//
//  Created by 金子広樹 on 2023/05/07.
//

import SwiftUI
import PencilKit

struct ContentView: View {
    @ObservedObject var viewModel = ContentViewModel.shared
    @State private var isShowSelectPenWindow: Bool = false      // ペン選択ウィンドウの表示有無
    @State private var isShowSelectColorWindow: Bool = false    // 色選択ウィンドウの表示有無
    
    var body: some View {
            GeometryReader { geometry in
                ZStack {
                    VStack {
                        TopbarView()
                            .frame(height: 40)
                        PenKitView()
                            .border(able, width: canvasBorderWidth)
                        BottombarView()
                            .frame(height: 50)
                    }
                }
                .onAppear {
                    viewModel.globalRect = geometry.frame(in: .global)
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ContentViewModel())
    }
}
