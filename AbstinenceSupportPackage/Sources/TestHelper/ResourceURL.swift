// Created by okazakishinya on 2025/02/16.

import Foundation

enum ResourceURL {
    static func url(forResource name: String, withExtension ext: String) -> URL? {
        Bundle.module.url(forResource: name, withExtension: ext)
    }
}
