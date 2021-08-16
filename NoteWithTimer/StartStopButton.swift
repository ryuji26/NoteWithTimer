//
//  StartStopButton.swift
//  NoteWithTimer
//
//  Created by 髙橋　竜治 on 2021/08/16.
//

import SwiftUI

struct ButtonsView: View {
    @EnvironmentObject var timeManager: TimeManager

    var body: some View {
        //running: ストップボタン/pause or stopped: スタートボタン
        Image(systemName: self.timeManager.timerStatus == .running ? "stop.circle.fill" : "play.circle.fill")
            //Pickerの時間、分、秒がいずれも0だったらボタンの透明度を0.1に、そうでなければ1（不透明）に
            .opacity(self.timeManager.minSelection == 0 && self.timeManager.secSelection == 0 ? 0.1 : 1)
            //ボタンをタップした時のアクション
            .onTapGesture {
                // debug
                //print(self.timeManager.timerStatus)
                if timeManager.timerStatus == .stopped {
                    self.timeManager.setTimer()
                }
                //残り時間が0以外かつタイマーステータスが.running以外の場合
                if timeManager.duration != 0 && timeManager.timerStatus != .running {
                    self.timeManager.start()
                    //タイマーステータスが.runningの場合
                } else if timeManager.timerStatus == .running {
                    self.timeManager.reset()
                }
            }
    }
}
