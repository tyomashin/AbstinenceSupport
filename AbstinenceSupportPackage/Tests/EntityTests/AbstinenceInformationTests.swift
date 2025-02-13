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
        let abstinenceInformation = AbstinenceInformation(title: "sample", targetDays: targetDays, scheduledReportDate: Date(), penalties: .free, progressStatus: .inProgress, startDate: Date())
        #expect(abstinenceInformation.normalizedTargetDays == expectedResult)
    }
    
    @Test("正規化された報告回数（normalizedReportedCount）が意図した範囲に制御されていること", arguments: [
        // 例）報告回数が100の場合、正規化された回数も100
        (100, 100),
        (0, 0),
        // 例）報告回数が-1という不正値の場合、正規化された回数は0
        (-1, 0),
    ]) func normalizedReportedCount(reportedCount: Int, expectedResult: Int) async throws {
        let abstinenceInformation = AbstinenceInformation(title: "sample", targetDays: 0, scheduledReportDate: Date(), penalties: .free, progressStatus: .inProgress, startDate: Date(), reportedCount: reportedCount)
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
        let abstinenceInformation = AbstinenceInformation(title: "sample", targetDays: targetDays, scheduledReportDate: Date(), penalties: .free, progressStatus: .inProgress, startDate: Date(), reportedCount: reportedCount)
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
        let abstinenceInformation = AbstinenceInformation(title: "sample", targetDays: 0, scheduledReportDate: Date(), penalties: .free, progressStatus: .inProgress, startDate: startDate)
        #expect(abstinenceInformation.elapsedDays == expectedResult)
    }
}
