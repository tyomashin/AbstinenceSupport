// Created by okazakishinya on 2025/02/16.

import Foundation
import Entity

@MainActor
public protocol AbstinenceStartRootViewModelProtocol: ObservableObject {

    var navigationPath: [AbstinenceStartNavigationPath] { get set }
    var targetDays: Int { get }
    var reportTime: Date { get }

    func tappedNameEntryNextButton(title: String, detail: String?)
    func tappedTargetDaysNextButton(targetDays: Int)
    func tappedReportTimeNextButton(reportTime: Date)
}
