//
//  TimeFormatting.swift
//  zRingSize
//
//  Created by KMUSER on 2024/04/04.
//

import Foundation

func calcTimeSince(dateString: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    
    guard let date = dateFormatter.date(from: dateString) else {
        return ""
    }
    
    let minutes = Int(-date.timeIntervalSinceNow) / 60
    let hours = minutes / 60
    let days = hours / 24
    
    if days >= 10 {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    } else if minutes < 60 {
        return "\(minutes)분 전"
    } else if minutes >= 60 && hours < 24 {
        return "\(hours)시간 전"
    } else {
        return "\(days)일 전"
    }
}
