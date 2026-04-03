import SwiftUI

struct CreateView: View {
    private let accent = Color(red: 205.0 / 255.0, green: 249.0 / 255.0, blue: 95.0 / 255.0)
    private let textPrimary = Color(red: 251.0 / 255.0, green: 250.0 / 255.0, blue: 255.0 / 255.0)
    private let textSecondary = Color(red: 163.0 / 255.0, green: 160.0 / 255.0, blue: 192.0 / 255.0)
    private let backgroundPrimary = Color(red: 14.0 / 255.0, green: 11.0 / 255.0, blue: 30.0 / 255.0)
    private let cardBackground = Color(red: 29.0 / 255.0, green: 25.0 / 255.0, blue: 55.0 / 255.0)
    private let chipBackground = Color(red: 36.0 / 255.0, green: 32.0 / 255.0, blue: 66.0 / 255.0)

    @State private var prompt: String = ""

    var body: some View {
        ZStack {
            backgroundPrimary
                .ignoresSafeArea()

            VStack(spacing: 0) {
                createHeader

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 20) {
                        promptSection
                        lengthAndOutputSection
                        styleSection
                        instrumentalToggleSection
                        generateButton
                    }
                    .padding(16)
                }
            }
        }
    }

    private var createHeader: some View {
        HStack {
            Text("Create")
                .font(.system(size: 32, weight: .bold))
                .foregroundStyle(textPrimary)

            Spacer()

            HStack(spacing: 10) {
                HStack(spacing: 4) {
                    Image(systemName: "hockey.puck.fill")
                        .font(.system(size: 18, weight: .regular))
                    Text("135")
                        .font(.system(size: 17, weight: .medium))
                }
                .foregroundStyle(Color(red: 14/255, green: 11/255, blue: 30/255))
                .padding(.horizontal, 12)
                .frame(height: 40)
                .background(accent)
                .clipShape(Capsule())

                Button {
                    // settings
                } label: {
                    Image(systemName: "gearshape")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundStyle(textPrimary)
                        .frame(width: 40, height: 40)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 24)
    }

    private var promptSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Prompt")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(textPrimary)

            VStack(alignment: .leading, spacing: 12) {
                TextEditor(text: $prompt)
                    .scrollContentBackground(.hidden)
                    .font(.system(size: 15))
                    .foregroundStyle(textSecondary)
                    .frame(minHeight: 120)
                    .padding(8)
                    .background(
                        cardBackground.opacity(0.8)
                            .cornerRadius(24)
                    )

                Button {
                    // Enhance prompt
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: "sparkles")
                        Text("Enhance with AI")
                    }
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(textPrimary)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(chipBackground)
                    .clipShape(Capsule())
                }
                .buttonStyle(.plain)
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
    }

    private var lengthAndOutputSection: some View {
        HStack(alignment: .top, spacing: 16) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Music Length")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(textPrimary)

                HStack {
                    Text("15 seconds")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundStyle(textPrimary)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(textPrimary)
                }
                .padding(.horizontal, 12)
                .frame(height: 40)
                .background(cardBackground.opacity(0.8))
                .clipShape(Capsule())
            }

            VStack(alignment: .leading, spacing: 10) {
                Text("Output")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(textPrimary)

                HStack {
                    Text("MP3 (128 kbps)")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundStyle(textPrimary)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(textPrimary)
                }
                .padding(.horizontal, 12)
                .frame(height: 40)
                .background(cardBackground.opacity(0.8))
                .clipShape(Capsule())
            }
        }
    }

    private var styleSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Style of Music")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(textPrimary)

                Spacer()

                VStack(alignment: .trailing, spacing: 2) {
                    Text("Selected")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(textPrimary)
                    Text("1/1 Styles")
                        .font(.system(size: 15, weight: .regular))
                        .foregroundStyle(textSecondary)
                }
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    styleCard(title: "Auto")
                    styleCard(title: "Pop")
                    styleCard(title: "Jazz")
                    styleCard(title: "Rap")
                    styleCard(title: "House")
                    styleCard(title: "Country")
                    styleCard(title: "Hip-Hop")
                    styleCard(title: "Classical")
                    styleCard(title: "Rock")
                }
            }
        }
    }

    private func styleCard(title: String) -> some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color.black.opacity(0.4))
                .frame(width: 90, height: 90)

            Text(title)
                .font(.system(size: 13, weight: .medium))
                .foregroundStyle(Color.white)
                .padding(.horizontal, 5)
                .padding(.vertical, 3)
                .background(Color.black.opacity(0.5))
                .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                .padding(5)
        }
    }

    private var instrumentalToggleSection: some View {
        HStack {
            Text("Instrumental")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(textPrimary)

            Spacer()

            Toggle("", isOn: .constant(false))
                .labelsHidden()
        }
    }

    private var generateButton: some View {
        Button {
            // Trigger generate
        } label: {
            HStack(spacing: 10) {
                HStack(spacing: 6) {
                    Image(systemName: "music.note.list")
                    Text("Generate")
                }
                .font(.system(size: 20, weight: .bold))

                Spacer()

                HStack(spacing: 6) {
                    Image(systemName: "hockey.puck.fill")
                    Text("3")
                }
                .font(.system(size: 20, weight: .semibold))
            }
            .foregroundStyle(textSecondary)
            .padding(.horizontal, 24)
            .frame(height: 60)
            .frame(maxWidth: .infinity)
            .background(Color(red: 36/255, green: 32/255, blue: 66/255))
            .clipShape(Capsule())
        }
        .buttonStyle(.plain)
        .padding(.top, 8)
    }
}

#Preview {
    CreateView()
}

