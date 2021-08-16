//
//  TimerButtonView.swift
//  NoteWithTimer
//
//  Created by 髙橋　竜治 on 2021/08/16.
//

import SwiftUI
import Combine
import AudioToolbox

/// タイマーポップオーバーを開くボタン
struct TimerButton: View {
    @EnvironmentObject var timeManager: TimeManager

    @State private var showTimerPopover = false

    var body: some View {
        HStack {
            Text("\(timeManager.displayTimer())")   // カウントダウン表示
            Image(systemName: "timer")
            ButtonsView()
                .onReceive(timeManager.timer) { _ in
                    guard self.timeManager.timerStatus == .running else { return }
                    //残り時間が0より大きい場合
                    if self.timeManager.duration > 0 {
                        //残り時間から -0.05 する
                        self.timeManager.duration -= 0.05
                        //残り時間が0以下の場合
                    } else {
                        //タイマーステータスを.stoppedに変更する
                        self.timeManager.timerStatus = .stopped
                        //アラーム音を鳴らす
                        AudioServicesPlayAlertSoundWithCompletion(self.timeManager.soundID, nil)
                        //バイブレーションを作動させる
                        AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) {}
                    }
                }
        }
        .font(Font.title.monospacedDigit())
        .onTapGesture { self.showTimerPopover = true }
        .popover(isPresented: $showTimerPopover) {
            TimerView(isShow: self.$showTimerPopover)
                .environmentObject(self.timeManager)
        }

    }

}
