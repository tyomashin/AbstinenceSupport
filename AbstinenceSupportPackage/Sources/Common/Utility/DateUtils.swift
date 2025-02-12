// Created by okazakishinya on 2025/02/12.

import Foundation

public struct DateUtils {
    static let calendar: Calendar = Calendar(identifier: .gregorian)

    public static func daysBetween(from start: Date, to end: Date) -> Int {
        let startOfDay = calendar.startOfDay(for: start)
        let endOfDay = calendar.startOfDay(for: end)
        return calendar.dateComponents([.day], from: startOfDay, to: endOfDay).day ?? 0
    }

    static func makeDate(year: Int, month: Int, day: Int) -> Date? {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        return calendar.date(from: dateComponents)
    }

    static func add(days: Int, to date: Date) -> Date? {
        calendar.date(byAdding: .day, value: days, to: date)
    }
}
