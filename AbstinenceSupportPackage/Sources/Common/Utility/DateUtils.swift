// Created by okazakishinya on 2025/02/12.

import Foundation

public struct DateUtils {
    public typealias YearMonthDay = (year: Int, month: Int, day: Int)
    public typealias Time = (hour: Int, minute: Int, second: Int)

    static let calendar: Calendar = Calendar(identifier: .gregorian)

    public static func daysBetween(from start: Date, to end: Date) -> Int {
        let startOfDay = calendar.startOfDay(for: start)
        let endOfDay = calendar.startOfDay(for: end)
        return calendar.dateComponents([.day], from: startOfDay, to: endOfDay).day ?? 0
    }

    public static func hoursBetween(from start: Date, to end: Date) -> Int {
        return calendar.dateComponents([.hour], from: start, to: end).hour ?? 0
    }

    public static func yearMonthDay(from date: Date) -> YearMonthDay {
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        return (components.year ?? 2000, components.month ?? 1, components.day ?? 1)
    }

    public static func time(from date: Date) -> Time {
        let components = calendar.dateComponents([.hour, .minute, .second], from: date)
        return (components.hour ?? 0, components.minute ?? 0, components.second ?? 0)
    }

    public static func apply(time: Time, to date: Date) -> Date {
        var components = calendar.dateComponents([.year, .month, .day], from: date)
        components.hour = time.hour
        components.minute = time.minute
        components.second = time.second
        return calendar.date(from: components) ?? date
    }

    static func makeDate(year: Int, month: Int, day: Int) -> Date? {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        return calendar.date(from: dateComponents)
    }

    static func makeDate(year: Int, month: Int, day: Int, time: Time) -> Date? {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = time.hour
        dateComponents.minute = time.minute
        dateComponents.second = time.second
        return calendar.date(from: dateComponents)
    }

    static func makeDate(from time: Time) -> Date? {
        var dateComponents = DateComponents()
        dateComponents.year = 2020
        dateComponents.month = 1
        dateComponents.day = 1
        dateComponents.hour = time.hour
        dateComponents.minute = time.minute
        dateComponents.second = time.second
        return calendar.date(from: dateComponents)
    }

    public static func add(days: Int, to date: Date) -> Date? {
        calendar.date(byAdding: .day, value: days, to: date)
    }

    public static func add(hours: Int, to date: Date) -> Date? {
        calendar.date(byAdding: .hour, value: hours, to: date)
    }
}
