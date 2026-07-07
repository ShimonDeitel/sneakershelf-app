import SwiftUI

@main
struct SneakerShelfApp: App {
    @StateObject private var store = SneakerShelfStore()
    @StateObject private var purchases = PurchaseManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
                .environmentObject(purchases)
                .preferredColorScheme(.dark)
        }
    }
}
