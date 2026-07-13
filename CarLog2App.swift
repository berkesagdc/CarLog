import SwiftUI
import SwiftData

@main
struct CarLog2App: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [
            Car.self,
            Maintenance.self
        ])
    }
}
