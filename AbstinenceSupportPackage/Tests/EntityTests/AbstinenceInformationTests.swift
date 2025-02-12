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
    
    @Test("進捗率（rateOfProgress）が意図した範囲に制御されていること", arguments: [
        // 例）目標日数が10日、5日前に禁欲開始した場合、進捗率は50%
        (10, DateUtils.add(days: -5, to: Date())!, 0.5),
        // 例）目標日数が20日、20日前に禁欲開始した場合、進捗率は100%
        (20, DateUtils.add(days: -20, to: Date())!, 1),
        // 例）目標日数が20日、10日前に禁欲開始した場合、進捗率は50%
        (20, DateUtils.add(days: -10, to: Date())!, 0.5),
        // 例）目標日数が20日、1日後に禁欲開始という不正値の場合は本日に補正され、進捗率は0%
        (20, DateUtils.add(days: 1, to: Date())!, 0),
    ]) func rateOfProgress(targetDays: Int, startDate: Date, expectedResult: Float) async throws {
        let abstinenceInformation = AbstinenceInformation(title: "sample", targetDays: targetDays, scheduledReportDate: Date(), penalties: .free, progressStatus: .inProgress, startDate: startDate)
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
