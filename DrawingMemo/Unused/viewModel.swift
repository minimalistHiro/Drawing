////
////  viewModel.swift
////  DrawingMemo
////
////  Created by 金子広樹 on 2023/06/08.
////
//
//import SwiftUI
//
//struct PointData: Identifiable {
//    var id: UUID = UUID()
//    var points: [CGPoint]
//    var color: Color
//    var lineWidth: CGFloat
//}
//
//class viewModel: NSObject, ObservedObject {
//    // SwiftUIのViewをUIViewに変換し,canvasをキャプチャ
//    func capture() -> UIImage {
//        let window = UIWindow(frame: canvasRect)
//        let body = PenKitView()
//
//        let hosting = UIHostingController(rootView: body)
//        hosting.view.frame = window.frame
//        window.addSubview(hosting.view)
//        window.makeKeyAndVisible()
//
//        return hosting.view.renderedImage
//    }
//
//    //MARK: - Add image to Library
//    @objc func imageSaveCompletion(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
//        self.error = error
//        addAlertEntity()
//        isShowAlert = true
//    }
//}
