// Created by okazakishinya on 2025/02/09.

import SwiftUI

public struct RootView: View {

    public init() {}

    public var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    RootView()
}
