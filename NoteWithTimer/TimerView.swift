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
        PickerView()
     }

  }
}
