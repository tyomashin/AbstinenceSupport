// Created by okazakishinya on 2025/02/09.

import SwiftUI
import Interface

public struct RootView<ViewModel: RootViewModelProtocol>: View {

    @StateObject var viewModel: ViewModel

    public init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

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
    RootView(viewModel: .preview)
}
