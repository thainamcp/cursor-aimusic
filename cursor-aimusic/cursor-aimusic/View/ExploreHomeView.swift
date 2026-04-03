import SwiftUI

struct ExploreHomeView: View {
    private let accent = Color(red: 205.0 / 255.0, green: 249.0 / 255.0, blue: 95.0 / 255.0)
    private let textPrimary = Color(red: 251.0 / 255.0, green: 250.0 / 255.0, blue: 255.0 / 255.0)
    private let textSecondary = Color(red: 163.0 / 255.0, green: 160.0 / 255.0, blue: 192.0 / 255.0)

    private let cards: [GenreCard] = [
        .init(title: "Golden Hour", subtitle: "Pop • Chill & Relax", imageURLString: "http://localhost:3845/assets/31d62f8809a79ec588db02581e759816efbe7734.png"),
        .init(title: "Neon Love", subtitle: "Pop • Happy vibes", imageURLString: "http://localhost:3845/assets/075f505b052787dcdf2b28495f54ead33a3e8f62.png"),
        .init(title: "Street Crown", subtitle: "Rap • Hustle Mood", imageURLString: "http://localhost:3845/assets/4a05715d4ec01e3b0e705acb101e4f399cb9278a.png"),
        .init(title: "Fire Lines", subtitle: "Rap • Confidence Boost", imageURLString: "http://localhost:3845/assets/d18bdce0b9a8c12ce1c5a59f634b0e0b6c56c233.png"),
        .init(title: "Urban Echo", subtitle: "Hip Hop • Street Vibes", imageURLString: "http://localhost:3845/assets/a8cfc8a09e11916d1794b84afe5f8c9b7f4e0aa9.png"),
        .init(title: "Late Night Flow", subtitle: "Hip Hop • Chill Night", imageURLString: "http://localhost:3845/assets/d3be7cea157d6efdfedbeb7a41848846284c0c6f.png"),
        .init(title: "Dusty Roads", subtitle: "Country • Road Trip", imageURLString: "http://localhost:3845/assets/c2576cb264a2164118721a141946eb8ea4f1c61d.png"),
        .init(title: "Wild Horizon", subtitle: "Country • Freedom Vibes", imageURLString: "http://localhost:3845/assets/87194e1414c786b456d6e1933ba70e4f0a828564.png"),
        .init(title: "Moonlight Sonata AI", subtitle: "Classical • Deep Focus", imageURLString: "http://localhost:3845/assets/cf851d4174f8b9872d9635df4fef47c801343406.png"),
        .init(title: "Silent Symphony", subtitle: "Classical • Relax & Study", imageURLString: "http://localhost:3845/assets/22c5cf2a081d3684c2e61c99cbffe8800f3a7028.png"),
        .init(title: "Blue Smoke", subtitle: "Jazz • Late Night", imageURLString: "http://localhost:3845/assets/80162dbfea0a792ae084cfa34c50219479ae5c9d.png"),
        .init(title: "Velvet Groove", subtitle: "Jazz • Smooth & Chill", imageURLString: "http://localhost:3845/assets/407dd2f8c041bb07c30df8946f3fac7639153183.png"),
        .init(title: "Thunder Ride", subtitle: "Rock • High Energy", imageURLString: "http://localhost:3845/assets/678eec7096f77dd0d69a44f3b96fec4daf048ba6.png"),
        .init(title: "Broken Strings", subtitle: "Rock • Emotional", imageURLString: "http://localhost:3845/assets/9fa00dd34c1c67a42e73b357b935ed96e3c4aba8.png"),
        .init(title: "Midnight Pulse", subtitle: "House • Party Night", imageURLString: "http://localhost:3845/assets/6ca25524724cdd540c7d0fb4f25de1edb1a7e40c.png"),
        .init(title: "Electric Waves", subtitle: "House • Dance Floor", imageURLString: "http://localhost:3845/assets/536097fadf8a5ec29df0b05f662835c791f5c91b.png")
    ]

    var body: some View {
        VStack(spacing: 0) {
            header

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 15) {
                    Text("Music by Genre")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundStyle(textPrimary)

                    LazyVGrid(columns: [GridItem(.fixed(180)), GridItem(.fixed(180))], spacing: 10) {
                        ForEach(cards, id: \.id) { card in
                            GenreCardView(card: card, textPrimary: textPrimary, textSecondary: textSecondary)
                        }
                    }
                    .frame(width: 370)
                    .padding(.top, 0)
                }
                .padding(16)
            }
        }
    }
}

private extension ExploreHomeView {
    var header: some View {
        HStack {
                Text("Explore")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundStyle(textPrimary)

                Spacer()

                HStack(spacing: 10) {
                    GreenPuckButton(countText: "135",
                                     accent: accent,
                                    textOnAccent: Color(red: 14.0 / 255.0, green: 11.0 / 255.0, blue: 30.0 / 255.0))

                    Button {
                        // TODO: connect action.
                    } label: {
                        Image(systemName: "gearshape")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundStyle(textPrimary)
                            .frame(width: 40, height: 40)
                    }
                    .buttonStyle(.plain)
                }
            }
            .frame(height: 50)
            .padding(.horizontal, 16)
            .padding(.top, 16)
    }
}

private struct GreenPuckButton: View {
    let countText: String
    let accent: Color
    let textOnAccent: Color

    var body: some View {
        Button {
            // TODO: connect action.
        } label: {
            HStack(spacing: 4) {
                Image(systemName: "hockey.puck.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 22)
                    .foregroundStyle(textOnAccent)

                Text(countText)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(textOnAccent)
            }
            .frame(width: 80, height: 40)
            .background(accent)
            .clipShape(RoundedRectangle(cornerRadius: 999, style: .continuous))
        }
        .buttonStyle(.plain)
    }
}

private struct GenreCardView: View {
    let card: GenreCard
    let textPrimary: Color
    let textSecondary: Color

    var body: some View {
        ZStack(alignment: .topLeading) {
            AsyncImage(url: URL(string: card.imageURLString)) { phase in
                switch phase {
                case .empty:
                    Color.black
                case .success(let image):
                    image.resizable().scaledToFill()
                case .failure:
                    Color.black
                @unknown default:
                    Color.black
                }
            }
            .frame(width: 180, height: 180)

            Rectangle()
                .fill(Color.black.opacity(0.2))
                .frame(width: 180, height: 180)

            VStack(alignment: .leading, spacing: 4) {
                Text(card.title)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(textPrimary)
                    .frame(width: 145, alignment: .leading)
                    .lineLimit(1)

                Text(card.subtitle)
                    .font(.system(size: 13, weight: .regular))
                    .foregroundStyle(textSecondary)
                    .frame(width: 145, alignment: .leading)
                    .lineLimit(1)
            }
            .padding(.leading, 12)
            .padding(.top, 118)
        }
        .frame(width: 180, height: 180)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}

private struct GenreCard: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let imageURLString: String
}

#Preview {
    ExploreHomeView()
}

