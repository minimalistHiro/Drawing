////
////  CanvasView.swift
////  DrawingMemo
////
////  Created by 金子広樹 on 2023/05/07.
////
//
//import SwiftUI
//import RealmSwift
//
//struct CanvasView: View {
//    @ObservedObject var viewModel = ContentViewModel.shared
//    let realm = RealmCRUD()
//    @State private var tmpDrawPoints: PointData = PointData(points: [], color: able, lineWidth: 10)        // PointDataを一時保存用
//    @State private var canvasLocalRect: CGRect = .zero      // canvasのサイズ情報
//    @State private var opacity: Double = 0                  // 色選択時のフェードアウトアニメーション用変数
////    @State private var lines: [CGPoint]                     // 2点を結ぶ直線
////    @State private var intersection: [CGPoint]              // 2本の直線の交点
//
//    var body: some View {
//        GeometryReader { geometry in
//            ZStack {
//                Rectangle()
//                    .foregroundColor(disable)
//                    .onAppear {
//                        viewModel.canvasRect = geometry.frame(in: .global)
//                        canvasLocalRect = geometry.frame(in: .local)
////                        realm.read()
//                    }
//                // ドラッグ後の描画
//                ForEach(viewModel.endedDrawPoints) { data in
//                    Path { path in
//                        // 点のみの描画の場合と、連続した線の描画の場合の処理を分ける。
//                        if data.points.count == 1 {
//                            path.move(to: data.points[0])
//                            path.addLine(to: data.points[0])
//                        } else {
////                            path.addLines(data.points)
//                            var movePoint: CGPoint = CGPoint(x: 0, y: 0)
//
//                            for point in data.points {
////                                createLine(startPoint: movePoint, endPoint: point)
//                                movePoint = point
//                            }
//                            var count = 0
//                            var line2: CGPoint = CGPoint(x: 0, y: 0)
////                            for line in lines {
////                                if count == 2 {
////
////                                }
////                                intersection.append(calculationIntersection(line1: , line2: ))
////                                count += 1
////                            }
//                            for point in data.points {
////                                path.addArc(tangent1End: CGPoint(x: (point.x + movePoint.x) / 2, y: (point.y + movePoint.y) / 2),
////                                            tangent2End: movePoint, radius: 1.0)
////                                path.addQuadCurve(to: <#T##CGPoint#>, control: <#T##CGPoint#>)
//                                path.addLine(to: point)
//                                path.move(to: point)
//                                movePoint = point
//                            }
//                        }
//                    }
//                    .stroke(data.color, style: StrokeStyle(lineWidth: data.lineWidth, lineCap: .round, lineJoin: .round))
//                }
//                // ドラッグ中の描画
//                Path { path in
//                    path.addLines(tmpDrawPoints.points)
//                }
//                .stroke(tmpDrawPoints.color, style: StrokeStyle(lineWidth: viewModel.lineWidth, lineCap: .round, lineJoin: .round))
//                Circle()
//                    .foregroundColor(viewModel.selectedColor.color)
//                    .opacity(opacity)
//                    .padding(50)
//                    .onChange(of: viewModel.selectedColor) { _ in
//                        opacity = 1
//                        withAnimation(.easeIn(duration: 1.0)) {
//                            opacity = 0
//                        }
//                    }
//            }
//            .gesture(
//                DragGesture(minimumDistance: 0)
//                    .onChanged({ value in
//                        tmpDrawPoints.color = viewModel.selectedColor.color
//                        tmpDrawPoints.lineWidth = viewModel.lineWidth
//                        // 描き始め（tmpDrawPoints.pointsが空）且つ、指をタップしている座標がcanvas内ならば現在座標を加える。
//                        guard !tmpDrawPoints.points.isEmpty else {
//                            if drawingRange(point: value.location) {
//                                tmpDrawPoints.points.append(value.location)
//                            }
//                            return
//                        }
//
//                        // 現在座標と一つ前の座標の距離が130以下なら、現在座標を加える。
//                        if let lastPoint = tmpDrawPoints.points.last,
//                           filterDistance(startPoint: lastPoint, endPoint: value.location){
//                            tmpDrawPoints.points.append(value.location)
//                        }
//                    })
//                    .onEnded({ value in
////                        realm.create(tmpDrawPoints)
//                        viewModel.endedDrawPoints.append(tmpDrawPoints)
//                        tmpDrawPoints = PointData(points: [], color: able, lineWidth: 10)
//                    })
//            )
//        }
//    }
//
//    /// 座標の距離が近いかどうかを判定する。複数本の指をタップした場合もDragGestureはonChangedを呼ぶが、連続した線ではないのでフィルターをかける。
//    /// - Parameters:
//    ///   - startPoint: 開始座標
//    ///   - endPoint: 終わりの座標
//    /// - Returns: 距離が130以下且つ終わりの座標がcanvas内に含まれるならtrue、それ以外ならfalse
//    private func filterDistance(startPoint: CGPoint, endPoint: CGPoint) -> Bool {
//        let distance = sqrt(pow(Double(startPoint.x) - Double(endPoint.x), 2) + pow(Double(startPoint.y) - Double(endPoint.y), 2))
//        return distance <= 130 && drawingRange(point: endPoint)
//    }
//
//    /// 指をタップしている座標がcanvas内であるかどうかを判定する。
//    /// - Parameters:
//    ///   - point: 終わりの座標
//    /// - Returns: 終わりの座標がcanvas内に含まれるならtrue、それ以外ならfalse
//    private func drawingRange(point: CGPoint) -> Bool {
//        let minX = canvasLocalRect.minX + (viewModel.lineWidth / 2) + canvasBorderWidth
//        let maxX = canvasLocalRect.maxX - ((viewModel.lineWidth / 2) + canvasBorderWidth)
//        let minY = canvasLocalRect.minY + (viewModel.lineWidth / 2) + canvasBorderWidth
//        let maxY = canvasLocalRect.maxY - ((viewModel.lineWidth / 2) + canvasBorderWidth)
//        return (point.x >= minX && point.x <= maxX) && (point.y >= minY && point.y <= maxY)
//    }
//
////    private func createLine(startPoint: CGPoint,endPoint: CGPoint) {
////        let differenceX: CGFloat = endPoint.x - startPoint.x
////        let differenceY: CGFloat = endPoint.y - startPoint.y
////
////        let a: CGFloat = differenceX / differenceY
////        let b: CGFloat = startPoint.y - (a * startPoint.x)
////        lines.append(CGPointMake(a, b))
////    }
//
////    private func calculationIntersection(line1: CGPoint,line2: CGPoint) -> CGPoint {
////
////    }
//}
