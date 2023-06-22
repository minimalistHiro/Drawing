//
//  ContentViewModel.swift
//  DrawingMemo
//
//  Created by 金子広樹 on 2023/05/07.
//

import SwiftUI
import UIKit
import PencilKit

class ContentViewModel: NSObject, ObservableObject {
    static var shared: ContentViewModel = ContentViewModel()
    
    @Published var drawData: [DrawData] = Array(DrawData.findAll())
    @Published var alertEntity: AlertEntity?
    @Published var inputs: Inputs = .none                   // ボタン押下実行処理
    @Published var bottomTool: BottomTool = .tappedPen      // ツール選択ボタン
    @Published var isShowAlert: Bool = false                // アラート表示有無
    @Published var isShowActivity: Bool = false             // Activityの表示有無
    var error: Error?
    
    // CGRect & CGPoint
    @Published var globalRect: CGRect = .zero               // 画面全体の範囲
    @Published var canvasRect: CGRect = .zero               // キャンバス範囲
    
    // PencilKit
    @Published var pkcView: PKCanvasView = PKCanvasView()
    @Published var inkType: PKInkingTool.InkType = .pen     // ペンタイプ
    @Published var selectedColor: DrawColor = .black        // 線の色
    @Published var lineWidth: CGFloat = 10                  // 線の太さ
    
    enum Inputs {
        case none
        case tappedShareButton
        case tappedDeleteButton
    }
    
    enum BottomTool {
        case tappedEraser
        case tappedPen
    }
    
    // ボタン押下実行処理
    func apply() {
        switch inputs {
        case .none:
            break
        case .tappedShareButton:
            break
//            let captureImage = capture()
//            UIImageWriteToSavedPhotosAlbum(captureImage, self,
//                #selector(imageSaveCompletion(_: didFinishSavingWithError: contextInfo:)), nil)
        case .tappedDeleteButton:
            addAlertEntity()
            isShowAlert = true
        }
    }
    
    // アラートの作成
    func addAlertEntity() {
        switch inputs {
        case .none:
            break
        case .tappedShareButton:
            if error == nil {
                alertEntity = AlertEntity(title: "画像が保存されました",
                                          message: "",
                                          actionText: "OK",
                                          cancelText: "",
                                          button: .single)
            } else {
                alertEntity = AlertEntity(title: error?.localizedDescription ?? "",
                                          message: "",
                                          actionText: "OK",
                                          cancelText: "",
                                          button: .single)
            }
        case .tappedDeleteButton:
            alertEntity = AlertEntity(title: "",
                                      message: "全て削除しますか？",
                                      actionText: "削除",
                                      cancelText: "キャンセル",
                                      button: .double)
        }
    }
    
    // アラートの実行処理
    func alertAction() {
        switch inputs {
        case .none:
            break
        case .tappedShareButton:
            break
        case .tappedDeleteButton:
            pkcView.drawing = PKDrawing()
            DrawData.delete()
        }
    }
    
    func capture() -> UIImage {
        let image = pkcView.renderedImage
        return image
    }
    
    // 新規データの作成
    func create(_ data: Data) {
        let model = DrawData()
        
        // viewModelからmodelに描画データを追加
        model.data = data
        
        // viewModelからmodelにペンデータを追加
        let stringPen = convertInkTypeToString(inkType)
        model.pen = stringPen
        
        // viewModelからmodelに色データを追加
        let intColor = convertDrawColorToInt(selectedColor)
        model.color = intColor

        // viewModelからmodelに線の太さデータを追加
        let lineWidth = Double(lineWidth)
        model.lineWidth = lineWidth
        
        DrawData.add(model)
    }
    
    // データの取得
    func read() -> Data? {
        // modelからviewModelにペンデータを追加
        let inkTypePen = convertStringToInkType(drawData.last?.pen)
        inkType = inkTypePen
        
        // modelからviewModelに色データを追加
        let drawColor = convertIntToDrawColor(drawData.last?.color)
        selectedColor = drawColor
        
        // modelからviewModelに線の太さデータを追加
        if let width = drawData.last?.lineWidth {
            lineWidth = CGFloat(width)
        }
        
        return drawData.last?.data
    }
    
    // DrawColorからIntに変換
    private func convertDrawColorToInt(_ color: DrawColor) -> Int {
        switch color {
        case .black:
            return 0
        case .red:
            return 1
        case .blue:
            return 2
        }
    }
    
    // IntからDrawColorに変換
    private func convertIntToDrawColor(_ int: Int?) -> DrawColor {
        switch int {
        case 0:
            return .black
        case 1:
            return .red
        case 2:
            return .blue
        default:
            return .black
        }
    }
    
    // PKInkingTool.InkTypeからStringに変換
    private func convertInkTypeToString(_ inkType: PKInkingTool.InkType) -> String {
        switch inkType {
        case .pencil:
            return "pencil"
        case .pen:
            return "pen"
        case .marker:
            return "marker"
        @unknown default:
            return "pen"
        }
    }
    
    // StringからPKInkingTool.InkTypeに変換
    private func convertStringToInkType(_ string: String?) -> PKInkingTool.InkType {
        switch string {
        case "pencil":
            return .pencil
        case "pen":
            return .pen
        case "marker":
            return .marker
        default:
            return .pen
        }
    }
}
