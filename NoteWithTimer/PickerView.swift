//
//  PickerView.swift
//  NoteWithTimer
//
//  Created by 髙橋　竜治 on 2021/08/16.
//

import SwiftUI

struct PickerView: View {
    //TimeManagerのインスタンスを作成
    @EnvironmentObject var timeManager: TimeManager
    //デバイスのスクリーンの幅
    let screenWidth = UIScreen.main.bounds.width
    //デバイスのスクリーンの高さ
    let screenHeight = UIScreen.main.bounds.height
    //設定可能な分単位の数値
    var minutes = [Int](0..<60)
    //設定可能な秒単位の数値
    var seconds = [Int](0..<60)

    var body: some View {
        //ZStackでPickerとレイヤーで重なるようにボタンを配置
        ZStack{
            //時間、分、秒のPickerとそれぞれの単位を示すテキストをHStackで横並びに
            HStack {
                //分単位のPicker
                Picker(selection: self.$timeManager.minSelection, label: Text("minute")) {
                    ForEach(0 ..< self.minutes.count) { index in
                        Text("\(self.minutes[index])")
                            .tag(index)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: self.screenWidth * 0.1, height: self.screenWidth * 0.4)
                .clipped()
                //分単位を表すテキスト
                Text("min")
                    .font(.headline)

                //秒単位のPicker
                Picker(selection: self.$timeManager.secSelection, label: Text("second")) {
                    ForEach(0 ..< self.seconds.count) { index in
                        Text("\(self.seconds[index])")
                            .tag(index)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width:self.screenWidth * 0.1, height: self.screenWidth * 0.4)
                .clipped()
                //秒単位を表すテキスト
                Text("sec")
                    .font(.headline)
            }
        }
    }
}
