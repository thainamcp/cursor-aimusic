import SwiftUI

struct SplashScreenView: View {
    // Figma-provided assets for this node.
    private let imgSplashIntro = "http://localhost:3845/assets/2041e0b7d4f902a082cdec893cf597244cfefd59.png"
    private let imgBrandName = "http://localhost:3845/assets/77b8130a1280788e643c090c93389f0f3e31af33.png"

    private let uiMain = Color(red: 205.0 / 255.0, green: 249.0 / 255.0, blue: 95.0 / 255.0)
    private let textPrimary = Color(red: 251.0 / 255.0, green: 250.0 / 255.0, blue: 255.0 / 255.0)

    var body: some View {
        GeometryReader { proxy in
            let refWidth: CGFloat = 402
            let refHeight: CGFloat = 874
            let scaleX = proxy.size.width / refWidth
            let scaleY = proxy.size.height / refHeight
            let scale = min(scaleX, scaleY)

            func x(_ v: CGFloat) -> CGFloat { v * scaleX }
            func y(_ v: CGFloat) -> CGFloat { v * scaleY }

            let cornerRadius = 40.0 * scale

            ZStack {
                // Background image.
                AsyncImage(url: URL(string: imgSplashIntro)) { phase in
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
                .frame(width: proxy.size.width, height: proxy.size.height)

                // Green tint overlay from Figma variable `UI/Main Color` at 10% opacity.
                Rectangle()
                    .fill(uiMain.opacity(0.1))
                    .ignoresSafeArea()

                // Logo (equivalent to `Logo_Vertical`).
                VStack(spacing: 0) {
                    SonaBarsView(color: uiMain)
                        .frame(width: x(79.054), height: y(95.523))
                    Text("SONA")
                        .font(.system(size: y(36), weight: .semibold))
                        .foregroundStyle(textPrimary)
                        .lineLimit(1)
                }
                .offset(y: y(37.76))

                // Status bar + bottom content.
                VStack(spacing: 0) {
                    StatusBarView(
                        timeText: "9:41",
                        scaleX: x,
                        scaleY: y,
                        textColor: textPrimary,
                        dynamicIslandColor: .black
                    )
                    Spacer(minLength: 0)
                    BottomCompanyView(
                        brandImageURL: URL(string: imgBrandName),
                        scaleX: x,
                        scaleY: y,
                        textColor: textPrimary,
                        fromToBrandGap: y(15),
                        bottomContainerGap: y(10)
                    )
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        }
        .ignoresSafeArea()
    }
}

private struct StatusBarView: View {
    let timeText: String
    let scaleX: (CGFloat) -> CGFloat
    let scaleY: (CGFloat) -> CGFloat
    let textColor: Color
    let dynamicIslandColor: Color

    var body: some View {
        HStack(spacing: scaleX(6)) {
            Text(timeText)
                .font(.system(size: scaleY(17), weight: .semibold))
                .foregroundStyle(textColor)
                .monospacedDigit()

            RoundedRectangle(cornerRadius: scaleX(100))
                .fill(dynamicIslandColor)
                .frame(width: scaleX(125), height: scaleY(37))

            Spacer(minLength: 0)

            HStack(spacing: scaleX(7)) {
                Image(systemName: "antenna.radiowaves.left.and.right")
                    .font(.system(size: scaleY(12), weight: .regular))
                    .frame(width: scaleX(19.2), height: scaleY(12))
                    .foregroundStyle(textColor)

                Image(systemName: "wifi")
                    .font(.system(size: scaleY(12), weight: .regular))
                    .frame(width: scaleX(17.142), height: scaleY(12.328))
                    .foregroundStyle(textColor)

                Image(systemName: "battery.100")
                    .font(.system(size: scaleY(13), weight: .regular))
                    .frame(width: scaleX(27.328), height: scaleY(13))
                    .foregroundStyle(textColor)
            }
        }
        .padding(.horizontal, scaleX(16))
        .padding(.top, scaleY(11))
    }
}

private struct BottomCompanyView: View {
    let brandImageURL: URL?
    let scaleX: (CGFloat) -> CGFloat
    let scaleY: (CGFloat) -> CGFloat
    let textColor: Color
    let fromToBrandGap: CGFloat
    let bottomContainerGap: CGFloat

    var body: some View {
        VStack(spacing: bottomContainerGap) {
            VStack(spacing: fromToBrandGap) {
                Text("From")
                    .font(.system(size: scaleY(14), weight: .regular))
                    .foregroundStyle(textColor)

                ZStack {
                    if let url = brandImageURL {
                        AsyncImage(url: url) { phase in
                            switch phase {
                            case .empty:
                                Color.clear
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit()
                            case .failure:
                                Color.clear
                            @unknown default:
                                Color.clear
                            }
                        }
                    }
                }
                .frame(width: scaleX(93), height: scaleY(30))
            }

            RoundedRectangle(cornerRadius: scaleX(100))
                .fill(Color.white)
                .frame(width: scaleX(134), height: scaleY(5))
                .padding(.bottom, scaleY(8))
        }
        .frame(maxWidth: .infinity)
    }
}

private struct SonaBarsView: View {
    let color: Color

    var body: some View {
        // Approximate the Figma vector "Logo_Vertical" sound bars with rounded rectangles.
        GeometryReader { geo in
            let totalHeight = geo.size.height
            let totalWidth = geo.size.width

            // Ratios tuned to visually match the Figma vector silhouette.
            let barHeights = [
                0.40 * totalHeight,
                0.62 * totalHeight,
                0.98 * totalHeight,
                0.62 * totalHeight,
                0.40 * totalHeight
            ]

            let barWidths = [
                0.16 * totalWidth,
                0.20 * totalWidth,
                0.28 * totalWidth,
                0.20 * totalWidth,
                0.16 * totalWidth
            ]

            let cornerRadius = 0.45 * min(barWidths.max() ?? 10, barWidths.min() ?? 6)
            let gap = 0.04 * totalWidth

            HStack(spacing: gap) {
                Bar(height: barHeights[0], width: barWidths[0], color: color, cornerRadius: cornerRadius)
                Bar(height: barHeights[1], width: barWidths[1], color: color, cornerRadius: cornerRadius)
                Bar(height: barHeights[2], width: barWidths[2], color: color, cornerRadius: cornerRadius)
                Bar(height: barHeights[3], width: barWidths[3], color: color, cornerRadius: cornerRadius)
                Bar(height: barHeights[4], width: barWidths[4], color: color, cornerRadius: cornerRadius)
            }
            .frame(width: totalWidth, height: totalHeight)
        }
    }
}

private struct Bar: View {
    let height: CGFloat
    let width: CGFloat
    let color: Color
    let cornerRadius: CGFloat

    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
            .fill(color)
            .frame(width: width, height: height)
    }
}

#Preview {
    SplashScreenView()
}

