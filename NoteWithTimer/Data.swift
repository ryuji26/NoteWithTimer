//
//  Data.swift
//  NoteWithTimer
//
//  Created by 髙橋　竜治 on 2021/08/16.
//

import SwiftUI
import AudioToolbox

enum TimeFormat {
    case min
    case sec
}

enum TimerStatus {
    case running
    case pause
    case stopped
}

struct Sound: Identifiable {
    let id: SystemSoundID
    let soundName: String
}
