//
//  Date+Extensions.swift
//  zRingSize
//
//  Created by zero on 6/24/24.
//

import Foundation

extension Date {
    func timeAgoDisplay() -> String {
        let now = Date()
        let components = Calendar.current.dateComponents([.second, .minute, .hour, .day, .weekOfYear, .month, .year], from: self, to: now)
        
        if let year = components.year, year > 0 {
            return year == 1 ? "작년" : "\(year)년 전"
        } else if let month = components.month, month > 0 {
            return month == 1 ? "지난달" : "\(month)개월 전"
        } else if let week = components.weekOfYear, week > 0 {
            return week == 1 ? "지난주" : "\(week)주 전"
        } else if let day = components.day, day > 0 {
            return day == 1 ? "어제" : "\(day)일 전"
        } else if let hour = components.hour, hour > 0 {
            return "\(hour)시간 전"
        } else if let minute = components.minute, minute > 0 {
            return "\(minute)분 전"
        } else if let second = components.second, second > 0 {
            return second < 10 ? "방금 전" : "\(second)초 전"
        } else {
            return "방금 전"
        }
    }

    func formattedString() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        
        if Calendar.current.component(.year, from: self) != Calendar.current.component(.year, from: Date()) {
            formatter.dateFormat = "yyyy년 M월 d일 HH:mm"
        } else {
            formatter.dateFormat = "M월 d일 HH:mm"
        }
        
        return formatter.string(from: self)
    }
}
