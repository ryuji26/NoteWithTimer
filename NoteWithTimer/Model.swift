//
//  Model.swift
//  NoteWithTimer
//
//  Created by 髙橋　竜治 on 2021/08/16.
//

import SwiftUI
import Combine

/// タイマーの動作間隔【単位：秒】
/// + 結果を早く確認するためテスト中は0.5秒とする
let interval = 1
/// カウントダウンの初期値【単位：秒】
let startValue = 60

// モデル
public
class CountDownTimerModel: ObservableObject {

  /// カウンターそのもの　@Published変化した場合に再表示
  @Published
  var counter = startValue
  /// スタートボタンに表示するタイトル文字列　@Published変化した場合に再表示
  @Published var startButtonTitle = "スタート"
  /// スタートボタンをディスエイブルにするフラグ　@Published変化した場合に再表示
  @Published var startButtonDisable = false

  /// "00:00"フォーマットのタイマー残り時間文字列【最大59分59秒まで対応】
  var formatedTime: String {
     get {
        String(format: "%02d:%02d", counter / 60, counter % 60)
     }
  }
  /// カウントダウン中フラグ
  var nowCounting = false
  //:  Timerインスタンスは使わない
//   private var timer: Timer?

  /// sink(receiveValue:の戻り値用
  private var cancellable: AnyCancellable?

  /// カウントダウンボタン処理（一時停止を兼ねている）
  func start() {
     startButtonDisable = false
     if 0 < counter {
        if cancellable == nil {
           countDownStart()
        }
        else {
           nowCounting.toggle()
        }
     }
     else {
        // 何もしない
     }
     setTitle()
  }

  /// 実際のスタート処理
  /// + タイマーの繰り返し処理を含む
  ///    + 指定間隔でsinkのクロージャが呼ばれる　counterの値をマイナス1する
  ///    + counterがゼロになったらタイマーの繰り返し処理を止める
  ///    + ★一時停止中もクロージャは呼ばれ続ける
  private func countDownStart() {
     nowCounting = true
    cancellable = Timer.publish(every: TimeInterval(interval), on: .main, in: .default)
        .autoconnect()
        .sink {_ in
           // receiveValueは利用しない
           // assign(to:on:)ではなくsink(receiveValue:)のクロージャで処理する
           if self.nowCounting {
              self.counter -= 1
              // ゼロになったらカウントダウンを止める
              if 0 >= self.counter {
                 self.nowCounting = false
                 self.startButtonDisable = true
              }
           }
     }

  }

  /// スタートボタンに表示するタイトル文字列を適切に設定する
  private func setTitle() {
     if nowCounting {
        startButtonTitle = "一時停止"
     }
     else {
        startButtonTitle = "再開"
     }
  }

  /// リセット処理
  func reset() {
     counter = startValue
     startButtonDisable = false
     setTitle()
  }
}
