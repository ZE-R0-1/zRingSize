//
//  Date+Extensions.swift
//  zRingSize
//
//  Created by zero on 6/24/24.
//

import Foundation

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    return formatter
}()

extension String {
    var daysSince: Int {
        guard let date = dateFormatter.date(from: self) else {
            return 0
        }
        return Int(-date.timeIntervalSinceNow) / (60 * 60 * 24)
    }
    
    var timeSince: String {
        guard let date = dateFormatter.date(from: self) else {
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
}
