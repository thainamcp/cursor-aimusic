import SwiftUI

struct TabbarView: View {
    enum Tab: Hashable {
        case explore
        case create
        case library
    }

    @Binding var selected: Tab

    private let accent = Color(red: 205.0 / 255.0, green: 249.0 / 255.0, blue: 95.0 / 255.0)
    private let secondaryText = Color(red: 163.0 / 255.0, green: 160.0 / 255.0, blue: 192.0 / 255.0)
    private let borderColor = Color(red: 77.0 / 255.0, green: 68.0 / 255.0, blue: 126.0 / 255.0).opacity(0.4)

    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(borderColor)
                .frame(height: 0.3)

            HStack(spacing: 0) {
                tabItem(.explore, label: "Explore", systemIcon: "house")
                tabItem(.create, label: "Create", systemIcon: "sparkles")
                tabItem(.library, label: "Library", systemIcon: "music.note.list")
            }
            .padding(.top, 8)
            .frame(height: 51)
        }
        .contentShape(Rectangle())
    }

    @ViewBuilder
    private func tabItem(_ tab: Tab, label: String, systemIcon: String) -> some View {
        Button {
            selected = tab
        } label: {
            VStack(spacing: 3) {
                Image(systemName: systemIcon)
                    .font(.system(size: 17, weight: .semibold))
                Text(label)
                    .font(.system(size: 10, weight: .medium))
                    .tracking(-0.1)
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity)
            .foregroundStyle(selected == tab ? accent : secondaryText)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    StatefulPreviewWrapper(TabbarView.Tab.explore)
}

private struct StatefulPreviewWrapper: View {
    @State private var selected: TabbarView.Tab

    init(_ selected: TabbarView.Tab) {
        _selected = State(initialValue: selected)
    }

    var body: some View {
        TabbarView(selected: $selected)
    }
}

