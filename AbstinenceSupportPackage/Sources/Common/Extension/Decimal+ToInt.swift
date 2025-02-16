// Created by okazakishinya on 2025/02/17.

import Foundation

extension Decimal {
    public var intValue: Int {
        NSDecimalNumber(decimal: self).intValue
    }
}
