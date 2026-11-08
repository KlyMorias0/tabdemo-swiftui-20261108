import SwiftUI

@main
struct TabDemoApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                DemoPage(title: "Ana Sayfa", symbol: "house.fill")
                    .tabItem { Label("Ana Sayfa", systemImage: "house") }

                DemoPage(title: "Ara", symbol: "magnifyingglass")
                    .tabItem { Label("Ara", systemImage: "magnifyingglass") }

                DemoPage(title: "Profil", symbol: "person.crop.circle.fill")
                    .tabItem { Label("Profil", systemImage: "person") }
            }
            .tint(.indigo)
        }
    }
}

private struct DemoPage: View {
    let title: String
    let symbol: String

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: symbol)
                .font(.system(size: 52))
                .foregroundStyle(.indigo)
            Text(title)
                .font(.title.bold())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(uiColor: .systemGroupedBackground))
    }
}
