//
//  PencilKit.swift
//  DrawingMemo
//
//  Created by 金子広樹 on 2023/06/04.
//

import SwiftUI
import PencilKit

struct PenKitView: UIViewRepresentable {
    @ObservedObject var viewModel = ContentViewModel.shared
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject {
        let parent: PenKitView
        
        init(_ parent: PenKitView) {
            self.parent = parent
            parent.viewModel.pkcView.backgroundColor = UIColor(disable)
            // 自分の指で描けるようにする
            parent.viewModel.pkcView.drawingPolicy = PKCanvasViewDrawingPolicy.anyInput
            // Realmからデータを取得
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                if let data = parent.viewModel.read() {
                    parent.viewModel.pkcView.drawing = try! PKDrawing(data: data)
                }
            }
        }
    }
    
    func makeUIView(context: Context) -> PKCanvasView {
        viewModel.pkcView.delegate = context.coordinator
        return viewModel.pkcView
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        if viewModel.bottomTool == .tappedEraser {
            if #available(iOS 16.4, *) {
                uiView.tool = PKEraserTool(.bitmap, width: viewModel.lineWidth)
            } else {
                uiView.tool = PKEraserTool(.bitmap)
            }
        } else {
            uiView.tool = PKInkingTool(viewModel.inkType, color: UIColor(viewModel.selectedColor.color), width: viewModel.lineWidth)
        }
        context.coordinator.canvasViewDrawingDidChange(uiView)
    }
}

extension PenKitView.Coordinator: PKCanvasViewDelegate {
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        parent.viewModel.create(canvasView.drawing.dataRepresentation())
    }
}
