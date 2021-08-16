//
//  StartButtonView.swift
//  NoteWithTimer
//
//  Created by 髙橋　竜治 on 2021/08/16.
//

import SwiftUI
import Combine

/// カウント時間指定兼用のスタートボタンビュー
struct StartButton: View {
  var timerSec: Int = 30
  let unit: String
  let titleStr: String
  @EnvironmentObject var cd: CountDownTimerModel

  /// カウント時間を秒で指定するイニシャライザ
  /// - Parameter sec: カウント時間【秒単位】
  init(_ sec: Int) {
     timerSec = sec
     if 60 <= timerSec {
        titleStr = "\(timerSec / 60)"
        unit = "分"
     }
     else {
        titleStr = "\(timerSec)"
        unit = "秒"
     }
  }

  var body: some View {
     ZStack {
        Circle().stroke(lineWidth: 8)
        Text("\(titleStr)\(unit)")
     }
     .foregroundColor(self.cd.nowCounting ? Color.gray : Color.accentColor)
     .frame(width: 80, height: 80, alignment: .topLeading)
     .onTapGesture {
        if !self.cd.nowCounting {
           self.cd.counter = self.timerSec
           self.cd.start()
        }
     }
     .padding()
  }
}
