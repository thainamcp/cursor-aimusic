import SwiftUI

struct MainTabView: View {
    enum Tab: Hashable {
        case explore
        case create
        case library
    }

    @State private var selected: Tab = .explore

    private let background = Color(red: 14.0 / 255.0, green: 11.0 / 255.0, blue: 30.0 / 255.0)

    var body: some View {
        
        ZStack {
            
            VStack(spacing: 0) {
                Group {
                    switch selected {
                    case .explore:
                        ExploreHomeView()
                    case .create:
                        CreateView()
                    case .library:
                        PlaceholderTabView(title: "Library")
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                TabbarView(selected: Binding(
                    get: {
                        switch selected {
                        case .explore: return TabbarView.Tab.explore
                        case .create: return TabbarView.Tab.create
                        case .library: return TabbarView.Tab.library
                        }
                    },
                    set: { newValue in
                        switch newValue {
                        case .explore: selected = .explore
                        case .create: selected = .create
                        case .library: selected = .library
                        }
                    }
                ))
                .padding(.bottom, 16)
            }

            .clipShape(RoundedRectangle(cornerRadius: 45, style: .continuous))
            .ignoresSafeArea(edges: .bottom)
        }
        .background(background)
    }
}

private struct PlaceholderTabView: View {
    let title: String

    var body: some View {
        VStack(spacing: 12) {
            Text(title)
                .font(.system(size: 32, weight: .bold))
                .foregroundStyle(Color(red: 251.0 / 255.0, green: 250.0 / 255.0, blue: 255.0 / 255.0))
            Spacer()
        }
        .padding(.top, 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    MainTabView()
}

