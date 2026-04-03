import Foundation

struct PlayerTrack: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let subtitle: String
    let imageURLString: String
}

