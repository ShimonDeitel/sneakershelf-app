import SwiftUI

/// Sneaker Shelf's unique visual identity - a palette and mood distinct from every
/// sibling app in this portfolio, tuned to the sneaker domain.
enum AppTheme {
    static let background = Color(red: 0.059, green: 0.078, blue: 0.086)
    static let card = Color(red: 0.086, green: 0.114, blue: 0.125)
    static let accent = Color(red: 0.184, green: 0.820, blue: 0.776)
    static let secondary = Color(red: 0.949, green: 0.329, blue: 0.357)
    static let primaryText = Color(red: 0.918, green: 0.969, blue: 0.965)
    static let mutedText = Color(red: 0.918, green: 0.969, blue: 0.965).opacity(0.6)

    static let titleFont: Font = .system(.title2, design: .serif).weight(.bold)
    static let headlineFont: Font = .system(.headline, design: .rounded)
    static let bodyFont: Font = .system(.body, design: .rounded)
    static let captionFont: Font = .system(.caption, design: .monospaced)

    static let cornerRadius: CGFloat = 16
}

struct CardBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(AppTheme.card)
            .cornerRadius(AppTheme.cornerRadius)
    }
}

extension View {
    func cardStyle() -> some View { modifier(CardBackground()) }
}
