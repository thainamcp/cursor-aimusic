import SwiftUI

struct PlayerView: View {
    let track: PlayerTrack

    private let uiMain = Color(red: 205.0 / 255.0, green: 249.0 / 255.0, blue: 95.0 / 255.0)
    private let textPrimary = Color(red: 251.0 / 255.0, green: 250.0 / 255.0, blue: 255.0 / 255.0)
    private let textSecondary = Color(red: 163.0 / 255.0, green: 160.0 / 255.0, blue: 192.0 / 255.0)

    @Environment(\.dismiss) private var dismiss
    @State private var progress: Double = 0.5

    var body: some View {
        ZStack {
            // Background artwork.
            AsyncImage(url: URL(string: track.imageURLString)) { phase in
                switch phase {
                case .empty:
                    Color.black
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                case .failure:
                    Color.black
                @unknown default:
                    Color.black
                }
            }
            .ignoresSafeArea()

            // Dark gradient overlay to match Figma bottom fade.
            LinearGradient(
                colors: [
                    Color.black.opacity(0.0),
                    Color.black.opacity(0.4),
                    Color.black.opacity(0.8)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack {
                // Header row (back + dot page indicator).
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(textPrimary)
                            .frame(width: 40, height: 40)
                    }
                    .buttonStyle(.plain)

                    Spacer()

                    HStack(spacing: 6) {
                        Circle()
                            .fill(uiMain)
                            .frame(width: 8, height: 8)
                        Circle()
                            .fill(textSecondary.opacity(0.4))
                            .frame(width: 6, height: 6)
                    }

                    Spacer()

                    // Spacer to balance back button.
                    Color.clear
                        .frame(width: 40, height: 40)
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)

                Spacer()

                // Song info + controls area.
                VStack(spacing: 24) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(track.title)
                            .font(.system(size: 30, weight: .bold))
                            .foregroundStyle(textPrimary)

                        Text(track.subtitle)
                            .font(.system(size: 24, weight: .regular))
                            .foregroundStyle(textSecondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)

                    VStack(spacing: 12) {
                        // Progress slider.
                        Slider(value: $progress, in: 0...1)
                            .tint(uiMain)

                        HStack {
                            Text("2:46")
                                .font(.system(size: 16, weight: .regular))
                                .foregroundStyle(textSecondary)
                            Spacer()
                            Text("3:05")
                                .font(.system(size: 16, weight: .regular))
                                .foregroundStyle(textSecondary)
                        }
                        .padding(.horizontal, 16)
                    }

                    HStack(spacing: 40) {
                        Button {
                            // share
                        } label: {
                            Image(systemName: "square.and.arrow.up")
                                .font(.system(size: 20, weight: .regular))
                                .foregroundStyle(textPrimary)
                                .frame(width: 45, height: 45)
                        }
                        .buttonStyle(.plain)

                        Button {
                            // play / pause
                        } label: {
                            ZStack {
                                Circle()
                                    .stroke(uiMain, lineWidth: 2)
                                    .frame(width: 73, height: 73)

                                Circle()
                                    .fill(Color.black.opacity(0.9))
                                    .frame(width: 65, height: 65)

                                Image(systemName: "play.fill")
                                    .font(.system(size: 28, weight: .light))
                                    .foregroundStyle(uiMain)
                            }
                        }
                        .buttonStyle(.plain)

                        Button {
                            // download
                        } label: {
                            Image(systemName: "arrow.down.circle")
                                .font(.system(size: 20, weight: .regular))
                                .foregroundStyle(textPrimary)
                                .frame(width: 45, height: 45)
                        }
                        .buttonStyle(.plain)
                    }

                    // Home indicator spacer.
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 134, height: 5)
                        .cornerRadius(100)
                        .padding(.top, 8)
                }
                .padding(.bottom, 24)
            }
        }
    }
}

#Preview {
    PlayerView(
        track: PlayerTrack(
            title: "Neon Love",
            subtitle: "Pop • Happy vibes",
            imageURLString: "http://localhost:3845/assets/075f505b052787dcdf2b28495f54ead33a3e8f62.png"
        )
    )
}

