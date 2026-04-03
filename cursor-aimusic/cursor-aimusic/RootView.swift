import SwiftUI

struct RootView: View {
    @State private var showSplash = true

    var body: some View {
        ZStack {
            if showSplash {
                SplashScreenView()
                    .transition(.opacity)
            } else {
                MainTabView()
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.25), value: showSplash)
        .task {
            // Keep the splash visible briefly, then reveal the main UI.
            try? await Task.sleep(nanoseconds: 2_000_000_000)
            withAnimation {
                showSplash = false
            }
        }
    }
}

#Preview {
    RootView()
}

