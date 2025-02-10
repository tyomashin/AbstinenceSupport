// Created by okazakishinya on 2025/02/10.

import Foundation

@propertyWrapper
struct UserDefaultsWrapper<T: Codable> {

    private let key: String
    private let defaultValue: T
    private let userdef: UserDefaults

    public var wrappedValue: T {
        get {
            // UserDefaults にデータがなければデフォルト値を返す
            guard let data = userdef.object(forKey: key) as? Data else {
                return defaultValue
            }

            // データを取得
            let value = try? JSONDecoder().decode(T.self, from: data)
            return value ?? defaultValue
        }
        set {
            let data = try? JSONEncoder().encode(newValue)
            userdef.set(data, forKey: key)
        }
    }

    public init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
        userdef = UserDefaults.standard
    }
}
