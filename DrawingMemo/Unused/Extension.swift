////
////  Extension.swift
////  DrawingMemo
////
////  Created by 金子広樹 on 2023/06/08.
////
//
//import SwiftUI
//import RealmSwift
//
//class DrawPoints: Object, ObjectKeyIdentifiable {
//    @Persisted(primaryKey: true) var id: ObjectId
//    @Persisted var color: Int
//    @Persisted var lineWidth: Double
//    @Persisted var points = RealmSwift.List<Point>()
//}
//
//class Point: Object, ObjectKeyIdentifiable {
//    @Persisted(primaryKey: true) var id: ObjectId
//    @Persisted var x: Double = 0.0
//    @Persisted var y: Double = 0.0
//}
//
//extension DrawData {
//    // 全データの削除
//    func delete() {
//        let realm = try! Realm()
//        try! realm.write {
//            let table = realm.objects(DrawData.self)
//            realm.delete(table)
//        }
//    }
//
//    // データの保存
//    private func save(model: DrawData) {
//        let realm = try! Realm()
//        try! realm.write {
//            realm.add(model)
//        }
//    }
//
//    // 新規データの作成
//    func create(_ data: PointData) {
//        let model = DrawPoints()
//
//        // viewModelからmodelに色データを追加
//        let intColor = convertDrawColorToInt(viewModel.selectedColor)
//        model.color = intColor
//
//        // viewModelからmodelに線の太さデータを追加
//        let lineWidth = Double(data.lineWidth)
//        model.lineWidth = lineWidth
//
//        // viewModelからmodelに座標データを追加
//        var points = [Point()]
//        for cgpoint in data.points {
//            points.append(Point(value: ["x": cgpoint.x, "y": cgpoint.y]))
//        }
//        // pointsの最初の要素に（x = 0, y = 0）が格納されてしまうので削除.
//        points.remove(at: 0)
//
//        model.points.append(objectsIn: points)
//        save(model: model)
//    }
//
//    // データの取得
//    func read() {
//        let realm = try! Realm()
//        let results = realm.objects(DrawPoints.self)
//        var data = PointData(points: [], color: able, lineWidth: 10)
//
//        for drawPoint in results {
//            // modelからviewModelに色データを追加
//            let drawColor = convertIntToDrawColor(drawPoint.color)
//            data.color = drawColor.color
//
//            // modelからviewModelに線の太さデータを追加
//            let lineWidth = CGFloat(drawPoint.lineWidth)
//            data.lineWidth = lineWidth
//
//            // modelからviewModelに座標データを追加
//            for point in drawPoint.points {
//                data.points.append(CGPointMake(point.x, point.y))
//            }
//            // cgpointsの最初の要素に（x = 0, y = 0）が格納されてしまうので削除.
////            data.points.remove(at: 0)
//
//            viewModel.endedDrawPoints.append(data)
//            data = PointData(points: [], color: able, lineWidth: 10)
//        }
//    }
//
//    // データの保存
//    private func save(model: DrawPoints) {
//        let realm = try! Realm()
//        try! realm.write {
//            realm.add(model)
//        }
//    }
//}
