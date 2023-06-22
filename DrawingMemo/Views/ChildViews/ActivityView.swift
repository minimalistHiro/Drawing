//
//  ActivityView.swift
//  DrawingMemo
//
//  Created by 金子広樹 on 2023/06/02.
//

import SwiftUI

struct ActivityView: UIViewControllerRepresentable {
    
    let shareItems: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(
            activityItems: shareItems,
            applicationActivities: nil)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityView>) {
        // 処理なし
    }
}
