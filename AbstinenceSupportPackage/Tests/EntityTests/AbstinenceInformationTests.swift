// Created by okazakishinya on 2025/02/12.

import Foundation
import Testing
@testable import Entity
@testable import Common

struct AbstinenceInformationTests {
    
    @Test("正規化された禁欲日数（normalizedTargetDays）が意図した範囲に制御されていること", arguments: [
        // 例）目標日数が100日の場合、正規化された日数も100日
        (100, 100),
        (0, 0),
        // 例）目標日数が-1日という不正値の場合、正規化された日数は0日
        (-1, 0),
    ]) func normalizedTargetDays(targetDays: Int, expectedResult: Int) async throws {
        let abstinenceInformation = AbstinenceInformation(title: "sample", targetDays: targetDays, scheduledReportDate: Date(), penaltyInfo: .freePenaltyInfo(), startDate: Date())
        #expect(abstinenceInformation.normalizedTargetDays == expectedResult)
    }
    
    @Test("正規化された報告回数（normalizedReportedCount）が意図した範囲に制御されていること", arguments: [
        // 例）報告回数が100の場合、正規化された回数も100
        (100, 100),
        (0, 0),
        // 例）報告回数が-1という不正値の場合、正規化された回数は0
        (-1, 0),
    ]) func normalizedReportedCount(reportedCount: Int, expectedResult: Int) async throws {
        var abstinenceInformation = AbstinenceInformation(title: "sample", targetDays: 0, scheduledReportDate: Date(), penaltyInfo: .freePenaltyInfo(), startDate: Date())
        abstinenceInformation.reportedCount = reportedCount
        #expect(abstinenceInformation.normalizedReportedCount == expectedResult)
    }
    
    @Test("進捗率（rateOfProgress）が意図した範囲に制御されていること", arguments: [
        // 例）目標日数が10日、報告回数が5回の場合、進捗率は50%
        (10, 5, 0.5),
        // 例）目標日数が20日、報告回数が20回の場合、進捗率は100%
        (20, 20, 1),
        // 例）目標日数が20日、報告回数が10回の場合、進捗率は50%
        (20, 10, 0.5),
        // 例）目標日数が20日、報告回数が-1という不正値の場合は、進捗率は0%
        (20, -1, 0),
        // 例）目標日数が-1日で不正値、報告回数が10の場合は、進捗率は100%
        (-1, 10, 1),
    ]) func rateOfProgress(targetDays: Int, reportedCount: Int, expectedResult: Float) async throws {
        var abstinenceInformation = AbstinenceInformation(title: "sample", targetDays: targetDays, scheduledReportDate: Date(), penaltyInfo: .freePenaltyInfo(), startDate: Date())
        abstinenceInformation.reportedCount = reportedCount
        #expect(abstinenceInformation.rateOfProgress == expectedResult)
    }
    
    @Test("経過日数（elapsedDays）が意図した範囲に制御されていること", arguments: [
        // 例）開始日が1日前の場合、経過日数は1日
        (DateUtils.add(days: -1, to: Date())!, 1),
        (DateUtils.add(days: -100, to: Date())!, 100),
        // 例）開始日が本日の場合、経過日数は0
        (DateUtils.add(days: 0, to: Date())!, 0),
        // 例）開始日が1日後という不正値の場合、経過日数は0
        (DateUtils.add(days: 1, to: Date())!, 0),
        (DateUtils.add(days: 1000, to: Date())!, 0),
    ]) func elapsedDays(startDate: Date, expectedResult: Int) async throws {
        let abstinenceInformation = AbstinenceInformation(title: "sample", targetDays: 0, scheduledReportDate: Date(), penaltyInfo: .freePenaltyInfo(), startDate: startDate)
        #expect(abstinenceInformation.elapsedDays == expectedResult)
    }
    
    @Test("次回の報告予定日のチェック：初回禁欲開始日時が報告予定日時の６時間未満だった場合、初回報告予定日は開始日翌日になること", arguments: [
        (9, 0, 0),
        (12, 0, 0),
        (14, 0, 0)
    ])
    func nextReportStartDateWhenNearFirstScheduledReportDate(scheduledReportTime: DateUtils.Time) async throws {
        let scheduledReportDate = DateUtils.makeDate(from: scheduledReportTime)!
        let targetYearMonthDay: DateUtils.YearMonthDay = (2024, 1, 1)
        // 禁欲開始時間を9時とする
        let startDate = DateUtils.makeDate(year: targetYearMonthDay.year, month: targetYearMonthDay.month, day: targetYearMonthDay.day, time: (9, 0, 0))!
        // reportedCount は 0 で初回の達成報告前とする
        let info = AbstinenceInformation(title: "sample", targetDays: 10, scheduledReportDate: scheduledReportDate, penaltyInfo: .freePenaltyInfo(), startDate: startDate)
        // 次回報告予定日の時分秒を取得
        let nextReportStartTime = DateUtils.time(from: info.nextReportStartDate)

        // MARK: 評価
        
        // 次回報告予定日の時分秒が scheduledReportDate と同じになっていること
        #expect(nextReportStartTime == scheduledReportTime)
        // 次回報告予定日が翌日になっていること
        #expect(DateUtils.daysBetween(from: startDate, to: info.nextReportStartDate) == 1)
        // 次回報告終了日は次回報告予定日の1時間後になっていること
        #expect(info.nextReportEndDate == DateUtils.add(hours: 1, to: info.nextReportStartDate))
    }
    
    @Test("次回の報告予定日のチェック：初回禁欲開始日時が報告予定日時を６時間以上離れていた場合、初回報告予定日は開始日当日になること", arguments: [
        (15, 0, 0),
        (20, 0, 0),
        (23, 0, 0)
    ])
    func nextReportStartDateWhenFarFirstScheduledReportDate(scheduledReportTime: DateUtils.Time) async throws {
        let scheduledReportDate = DateUtils.makeDate(from: scheduledReportTime)!
        let targetYearMonthDay: DateUtils.YearMonthDay = (2024, 12, 31)
        // 禁欲開始時間を9時とする
        let startDate = DateUtils.makeDate(year: targetYearMonthDay.year, month: targetYearMonthDay.month, day: targetYearMonthDay.day, time: (9, 0, 0))!
        // reportedCount は 0 で初回の達成報告前とする
        let info = AbstinenceInformation(title: "sample", targetDays: 10, scheduledReportDate: scheduledReportDate, penaltyInfo: .freePenaltyInfo(), startDate: startDate)
        // 次回報告予定日の時分秒を取得
        let nextReportStartTime = DateUtils.time(from: info.nextReportStartDate)

        // MARK: 評価
        
        // 次回報告予定日の時分秒が scheduledReportDate と同じになっていること
        #expect(nextReportStartTime == scheduledReportTime)
        // 次回報告予定日が当日になっていること
        #expect(DateUtils.daysBetween(from: startDate, to: info.nextReportStartDate) == 0)
        // 次回報告終了日は次回報告予定日の1時間後になっていること
        #expect(info.nextReportEndDate == DateUtils.add(hours: 1, to: info.nextReportStartDate))
    }
    
    @Test("次回の報告予定日のチェック：初回禁欲開始日時が報告予定日時を６時間以上離れていた場合、2回目以降の報告予定日は「報告回数」日後になっていること", arguments: [
        // 報告予定時間：15:00 、報告回数：1回
        ((15, 0, 0), 1),
        // 報告予定時間：20:00 、報告回数：4回
        ((20, 0, 0), 4),
        // 報告予定時間：23:00 、報告回数：10回
        ((23, 0, 0), 10)
    ])
    func nextReportStartDateWhenReported(scheduledReportTime: DateUtils.Time, reportedCount: Int) async throws {
        let scheduledReportDate = DateUtils.makeDate(from: scheduledReportTime)!
        let targetYearMonthDay: DateUtils.YearMonthDay = (2024, 1, 1)
        // 禁欲開始時間を9時とする
        let startDate = DateUtils.makeDate(year: targetYearMonthDay.year, month: targetYearMonthDay.month, day: targetYearMonthDay.day, time: (9, 0, 0))!
        var info = AbstinenceInformation(title: "sample", targetDays: 10, scheduledReportDate: scheduledReportDate, penaltyInfo: .freePenaltyInfo(), startDate: startDate)
        info.reportedCount = reportedCount
        // 次回報告予定日の時分秒を取得
        let nextReportStartTime = DateUtils.time(from: info.nextReportStartDate)

        // MARK: 評価
        
        // 次回報告予定日の時分秒が scheduledReportDate と同じになっていること
        #expect(nextReportStartTime == scheduledReportTime)
        // 次回報告予定日が「報告回数」日後になっていること
        #expect(DateUtils.daysBetween(from: startDate, to: info.nextReportStartDate) == reportedCount)
        // 次回報告終了日は次回報告予定日の1時間後になっていること
        #expect(info.nextReportEndDate == DateUtils.add(hours: 1, to: info.nextReportStartDate))
    }
    
    @Suite("禁欲ステータス更新処理")
    struct UpdateProgressStatus {
        
        @Test("すでに禁欲に失敗している場合、そのままのステータスとする", arguments: [
            AbstinenceProgressStatus.penaltyPaidForFailure,
            AbstinenceProgressStatus.penaltyUnpaidForFailure,
        ]) func alreadyFailed(status: AbstinenceProgressStatus) async throws {
            var info = AbstinenceInformation(title: "sample", targetDays: 0, scheduledReportDate: Date(), penaltyInfo: .freePenaltyInfo(), startDate: Date())
            info.progressStatus = status
            info.updateProgressStatus(currentDate: Date())
            #expect(info.progressStatus == status)
        }
        
        @Test("報告回数が禁欲目標日数以上の場合、成功ステータスとする", arguments: [
            (1, 1),
            (20, 20),
            (30, 20),
        ]) func success(reportedCount: Int, targetDays: Int) async throws {
            var info = AbstinenceInformation(title: "sample", targetDays: targetDays, scheduledReportDate: Date(), penaltyInfo: .freePenaltyInfo(), startDate: Date())
            info.reportedCount = reportedCount
            info.updateProgressStatus(currentDate: Date())
            #expect(info.progressStatus == .success)
        }
        
        @Test("現在日時が次回報告終了時刻を過ぎてしまっている場合、失敗ステータスとする", arguments: [
            (
                DateUtils.makeDate(year: 2024, month: 1, day: 1, time: (9,0,0))!,
                DateUtils.makeDate(year: 2023, month: 12, day: 20, time: (0,0,0))!,
                DateUtils.makeDate(from: (0,0,0))!,
                1
            ),
            // 現在日時が2024/1/10 9:00、開始日時が2024/1/1 0:00
            // 初回報告日時は2024/1/2 2:00
            // 報告済み回数が8
            // -> 次回報告終了時刻は2024/1/10 3:00
            (
                DateUtils.makeDate(year: 2024, month: 1, day: 10, time: (9,0,0))!,
                DateUtils.makeDate(year: 2024, month: 1, day: 1, time: (0,0,0))!,
                DateUtils.makeDate(from: (2,0,0))!,
                8
            ),
            // 現在日時が2024/1/10 9:00、開始日時が2024/1/1 0:00
            // 初回報告日時は2024/1/1 6:00
            // 報告済み回数が8
            // -> 次回報告終了時刻は2024/1/10 7:00
            (
                DateUtils.makeDate(year: 2024, month: 1, day: 10, time: (9,0,0))!,
                DateUtils.makeDate(year: 2024, month: 1, day: 1, time: (0,0,0))!,
                DateUtils.makeDate(from: (6,0,0))!,
                8
            ),
        ]) func penaltyUnpaidForFailure(currentDate: Date, startDate: Date, scheduledReportDate: Date, reportedCount: Int) async throws {
            var info = AbstinenceInformation(title: "sample", targetDays: 20, scheduledReportDate: scheduledReportDate, penaltyInfo: .freePenaltyInfo(), startDate: startDate)
            info.reportedCount = reportedCount
            info.updateProgressStatus(currentDate: currentDate)
            #expect(info.progressStatus == .penaltyUnpaidForFailure)
        }
        
        @Test("成功でも失敗でもない場合、進行中ステータスとする", arguments: [
            // 現在日時が2024/1/1 9:00、開始日時が2024/1/1 0:00
            // 初回報告日時は2024/1/1 9:00
            // 報告済み回数が0
            // -> 次回報告終了時刻は2024/1/1 10:00
            (
                DateUtils.makeDate(year: 2024, month: 1, day: 1, time: (9,0,0))!,
                DateUtils.makeDate(year: 2024, month: 1, day: 1, time: (0,0,0))!,
                DateUtils.makeDate(from: (9,0,0))!,
                0
            ),
            // 現在日時が2024/1/10 9:00、開始日時が2024/1/1 0:00
            // 初回報告日時は2024/1/2 2:00
            // 報告済み回数が9
            // -> 次回報告終了時刻は2024/1/11 3:00
            (
                DateUtils.makeDate(year: 2024, month: 1, day: 10, time: (9,0,0))!,
                DateUtils.makeDate(year: 2024, month: 1, day: 1, time: (0,0,0))!,
                DateUtils.makeDate(from: (2,0,0))!,
                9
            ),
            // 現在日時が2024/1/9 9:00、開始日時が2024/1/1 0:00
            // 初回報告日時は2024/1/1 6:00
            // 報告済み回数が9
            // -> 次回報告終了時刻は2024/1/10 7:00
            (
                DateUtils.makeDate(year: 2024, month: 1, day: 9, time: (9,0,0))!,
                DateUtils.makeDate(year: 2024, month: 1, day: 1, time: (0,0,0))!,
                DateUtils.makeDate(from: (6,0,0))!,
                9
            ),
        ]) func inProgress(currentDate: Date, startDate: Date, scheduledReportDate: Date, reportedCount: Int) async throws {
            var info = AbstinenceInformation(title: "sample", targetDays: 20, scheduledReportDate: scheduledReportDate, penaltyInfo: .freePenaltyInfo(), startDate: startDate)
            info.reportedCount = reportedCount
            info.updateProgressStatus(currentDate: currentDate)
            #expect(info.progressStatus == .inProgress)
        }
    }
}
