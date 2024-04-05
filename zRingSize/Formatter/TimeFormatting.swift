//
//  TimeFormatting.swift
//  zRingSize
//
//  Created by KMUSER on 2024/04/04.
//

import Foundation

func calcTimeSince(date: Date) -> String {
    let minutes = Int(-date.timeIntervalSinceNow)/60
    let hours = minutes/60
    let days = hours/24
    
    if minutes < 60 {
        return "\(minutes)분 전"
    } else if minutes >= 60 && hours < 24 {
        return "\(hours)시간 전"
    } else {
        return "\(days)일 전"
    }
}
