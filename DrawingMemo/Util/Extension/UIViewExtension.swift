//
//  UIViewExtension.swift
//  DrawingMemo
//
//  Created by 金子広樹 on 2023/05/09.
//

import UIKit

extension UIView {
    // UIViewで画面キャプチャを取得
    var renderedImage: UIImage {
        let rect = self.bounds
        
        let rendered = UIGraphicsImageRenderer(bounds: rect)
        return rendered.image { renderedContext in
            layer.render(in: renderedContext.cgContext)
        }
    }
}
