import SwiftUI

@main
struct ChiefappApp: App {
    var body: some Scene {
        WindowGroup {
          ChiefInjector.provideHomeView()
        }
    }
}
