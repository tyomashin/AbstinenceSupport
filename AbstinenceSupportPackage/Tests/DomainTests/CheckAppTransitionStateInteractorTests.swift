// Created by okazakishinya on 2025/02/13.

import Foundation
import Testing
import Dependencies
@testable import Domain
@testable import Entity
@testable import TestHelper

struct CheckAppTransitionStateInteractorTests {

    var interactor: CheckAppTransitionStateInteractor!
    var fetchAbstinenceInfoInteractor: FetchAbstinenceInfoInteractorStub
    var userDefaultsHelperStub: UserDefaultsHelperStub
    var abstinenceInformation: AbstinenceInformation
    
    init() {
        self.abstinenceInformation = .init(title: "sample", targetDays: 0, scheduledReportDate: Date(), penaltyInfo: .freePenaltyInfo(), progressStatus: .inProgress, startDate: Date())
        self.fetchAbstinenceInfoInteractor = FetchAbstinenceInfoInteractorStub()
        self.userDefaultsHelperStub = UserDefaultsHelperStub()
        self.interactor = withDependencies {
            $0.fetchAbstinenceInfoInteractor = fetchAbstinenceInfoInteractor
            $0.userDefaultsHelper = userDefaultsHelperStub
        } operation: {
            CheckAppTransitionStateInteractor()
        }
    }
    
    @Test("禁欲情報が存在しない、かつアプリ初回起動時の場合はオンボーディングに遷移") func onboarding() async throws {
        fetchAbstinenceInfoInteractor.abstinenceInformation = nil
        userDefaultsHelperStub.isFirstLaunch = true

        switch await interactor.execute() {
        case .onboarding:
            #expect(true)
        default:
            #expect(Bool(false))
        }
    }

    @Test("禁欲情報が存在しない、かつアプリ初回起動時でない場合は禁欲開始画面に遷移") func abstinenceStartWhenNotExistInfo() async throws {
        fetchAbstinenceInfoInteractor.abstinenceInformation = nil
        userDefaultsHelperStub.isFirstLaunch = false

        switch await interactor.execute() {
        case .abstinenceStart:
            #expect(true)
        default:
            #expect(Bool(false))
        }
    }
    
    @Test("禁欲情報が存在する、かつ前回禁欲に失敗していない場合はトップ画面に遷移", arguments: [
        AbstinenceProgressStatus.success,
        AbstinenceProgressStatus.inProgress
    ]) mutating func abstinenceFailure(progressStatus: AbstinenceProgressStatus) async throws {
        self.abstinenceInformation.progressStatus = progressStatus
        fetchAbstinenceInfoInteractor.abstinenceInformation = abstinenceInformation

        switch await interactor.execute() {
        case .top(abstinenceInfo: let info):
            #expect(info == abstinenceInformation)
        default:
            #expect(Bool(false))
        }
    }
    
    @Test("禁欲情報が存在する、かつ前回禁欲に失敗している、かつペナルティ支払い済みの場合は禁欲開始画面に遷移") mutating func abstinenceStartWhenPenaltyPaidForFailure() async throws {
        self.abstinenceInformation.progressStatus = .penaltyPaidForFailure
        fetchAbstinenceInfoInteractor.abstinenceInformation = abstinenceInformation

        switch await interactor.execute() {
        case .abstinenceStart:
            #expect(true)
        default:
            #expect(Bool(false))
        }
    }
    
    @Test("禁欲情報が存在する、かつ前回禁欲に失敗している、かつペナルティ未払いの場合は禁欲失敗画面に遷移") mutating func abstinenceFailure() async throws {
        self.abstinenceInformation.progressStatus = .penaltyUnpaidForFailure
        fetchAbstinenceInfoInteractor.abstinenceInformation = abstinenceInformation

        switch await interactor.execute() {
        case .abstinenceFailure(abstinenceInfo: let info):
            #expect(info == abstinenceInformation)
        default:
            #expect(Bool(false))
        }
    }
}
