//
//  TimerView.swift
//  NoteWithTimer
//
//  Created by 髙橋　竜治 on 2021/08/16.
//

import SwiftUI
import Combine

/// タイマーのスタート／停止と表示ビュー
/// + ポップオーバー／シート表示対応番
/// + イニシャライザの引数で閉じるためのバインディングを渡す
struct TimerView: View {
  @Binding var isShow: Bool
  /// CountDounTimerインスタンス
  /// + environmentObject(_:) メソッドでを設定する
  @EnvironmentObject var cd: CountDownTimerModel

  var body: some View {
     VStack {
        // 閉じるボタン
        HStack {
           Spacer()
           Button(action: { self.isShow = false }) {
              Text("閉じる")
                 .padding()
           }
        }
        // スタートボタングループ
        Group {
           HStack {
              Text("\(cd.formatedTime)")
                 .font(Font.largeTitle.monospacedDigit())
                 .fontWeight(.black)
                 .padding()
           }
           HStack {
              StartButton(60)
              StartButton(120)
           }
           // 一時停止ボタン（起動直後のみ「スタート」）
           Button(action: {
              self.cd.start()
           }) {
              Text(self.cd.startButtonTitle)
           }
           .disabled(cd.startButtonDisable)
           .padding()

        }
        .font(.title)

     }

  }
}
