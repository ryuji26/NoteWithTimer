//
//  TimerButtonView.swift
//  NoteWithTimer
//
//  Created by 髙橋　竜治 on 2021/08/16.
//

import SwiftUI
import Combine

/// タイマーポップオーバーを開くボタン
struct TimerButton: View {
  @EnvironmentObject var cd: CountDownTimerModel

  @State private var showTimerPopover = false

  var body: some View {
     HStack {
        Text("\(cd.formatedTime)")   // カウントダウン表示
        Image(systemName: "timer")
     }
     .font(Font.title.monospacedDigit())
     .onTapGesture { self.showTimerPopover = true }
     .popover(isPresented: $showTimerPopover) {
        TimerView(isShow: self.$showTimerPopover)
           .environmentObject(self.cd)
     }

  }

}