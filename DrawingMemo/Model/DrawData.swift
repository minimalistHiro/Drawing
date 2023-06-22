//
//  DrawPoints.swift
//  DrawingMemo
//
//  Created by 金子広樹 on 2023/05/07.
//

import SwiftUI
import RealmSwift

// 各種設定
let minLineWidth: Double = 1                            // 線の最小太さ
let maxLineWidth: Double = 30                           // 線の最大太さ

// サイズ
let bottomOutsideCircleButtonsSize: CGFloat = 40        // 色選択ボタンサイズ（外側）
let bottomInsideCircleButtonsSize: CGFloat = 30         // 色選択ボタンサイズ（内側）
let bottomEraserButtonsSize: CGFloat = 30               // 消しゴムボタンサイズ（内側）
let toolbarButtonsSize: CGFloat = 25                    // ツールバーボタンサイズ
let sliderMaxSize: CGFloat = 200                        // スライダー最大サイズ
let canvasBorderWidth: CGFloat = 2                      // canvasの枠線の太さ

// 固定色
let able: Color = Color("Able")                         // 文字・ボタン色
let disable: Color = Color("Disable")                   // 背景色
let highlight: Color = Color("Highlight")               // ハイライト

class DrawData: Object {
    @Persisted var data: Data
    @Persisted var pen: String
    @Persisted var color: Int
    @Persisted var lineWidth: Double
}

enum DrawColor {
    case black
    case red
    case blue
    
    var color: Color {
        switch self {
        case .black:
            return able
        case .red:
            return Color.red
        case .blue:
            return Color.blue
        }
    }
}

struct AlertEntity {
    // アラートボタンの個数
    enum AlertButton {
        case single
        case double
    }
    let title: String
    let message: String
    let actionText: String
    let cancelText: String
    let button: AlertButton
}

extension DrawData {
    private static var config = Realm.Configuration(schemaVersion: 1)
    private static var realm = try! Realm(configuration: config)
    
    static func findAll() -> Results<DrawData> {
        realm.objects(self)
    }
    
    static func add(_ data: DrawData) {
        try! realm.write {
            realm.add(data)
        }
    }
    
    static func delete() {
        try! realm.write {
            let table = realm.objects(self)
            realm.delete(table)
        }
    }
}
