import SwiftUI

@main
struct TabDemoApp: App {
    var body: some Scene {
        WindowGroup {
            Group {
                if #available(iOS 26.0, *) {
                    SystemTabs()
                } else {
                    ClassicSystemTabs()
                }
            }
            .tint(DemoStyle.accent)
            .preferredColorScheme(.dark)
        }
    }
}

private enum DemoStyle {
    static let accent = Color(red: 1, green: 0.52, blue: 0.51)
    static let background = Color(red: 0.055, green: 0.059, blue: 0.067)
    static let card = Color(red: 0.10, green: 0.105, blue: 0.115)
    static let placeholder = Color(red: 0.19, green: 0.195, blue: 0.205)
}

// The floating glass bar and separate search button are drawn by iOS itself.
@available(iOS 26.0, *)
private struct SystemTabs: View {
    @State private var query = ""

    var body: some View {
        TabView {
            Tab("Dinle", systemImage: "house.fill") {
                DemoPage(title: "Dinle")
            }
            Tab("Keşfet", systemImage: "square.grid.2x2.fill") {
                DemoPage(title: "Keşfet")
            }
            Tab("Kütüphane", systemImage: "square.stack.fill") {
                DemoPage(title: "Kütüphane")
            }
            Tab("Ara", systemImage: "magnifyingglass", role: .search) {
                NavigationStack {
                    SearchPage(query: query)
                        .searchable(text: $query, prompt: "Ara")
                }
            }
        }
    }
}

// Older iOS versions keep their own native, classic tab bar.
private struct ClassicSystemTabs: View {
    @State private var query = ""

    var body: some View {
        TabView {
            DemoPage(title: "Dinle")
                .tabItem { Label("Dinle", systemImage: "house.fill") }
            DemoPage(title: "Keşfet")
                .tabItem { Label("Keşfet", systemImage: "square.grid.2x2.fill") }
            DemoPage(title: "Kütüphane")
                .tabItem { Label("Kütüphane", systemImage: "square.stack.fill") }
            NavigationStack {
                SearchPage(query: query)
                    .searchable(text: $query, prompt: "Ara")
            }
            .tabItem { Label("Ara", systemImage: "magnifyingglass") }
        }
    }
}

private struct DemoPage: View {
    let title: String
    @State private var showingInfo = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    RoundedRectangle(cornerRadius: 18)
                        .fill(DemoStyle.card)
                        .frame(height: 370)

                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 22) {
                        ForEach(0..<6) { _ in
                            VStack(alignment: .leading, spacing: 10) {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(DemoStyle.placeholder)
                                    .aspectRatio(1, contentMode: .fit)
                                Capsule()
                                    .fill(DemoStyle.placeholder)
                                    .frame(width: 100, height: 11)
                            }
                        }
                    }
                }
                .accessibilityElement(children: .ignore)
                .accessibilityLabel("Demo kartları")
                .padding(20)
                .padding(.bottom, 20)
            }
            .background(DemoStyle.background)
            .navigationTitle(title)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingInfo = true
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                    .accessibilityLabel("Görünüm bilgisi")
                }
            }
            .sheet(isPresented: $showingInfo) {
                NavigationStack {
                    Form {
                        LabeledContent("Görünüm", value: "Koyu")
                        Text("Bu demo, iPhone'un yerel sekme çubuğunu kullanır. Cam görünüm ve ayrı arama düğmesi iOS 26 ve üzerinde gösterilir.")
                    }
                    .navigationTitle("Görünüm")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Bitti") { showingInfo = false }
                        }
                    }
                }
                .presentationDetents([.medium])
            }
        }
    }
}

private struct SearchPage: View {
    let query: String

    var body: some View {
        VStack(spacing: 14) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 46))
                .foregroundStyle(DemoStyle.accent)
            Text(query.isEmpty ? "Ara" : "Sonuç bulunamadı")
                .font(.title2.bold())
            Text(query.isEmpty ? "Aramak için bir şey yaz." : "Bu demo henüz içerik barındırmıyor.")
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(DemoStyle.background)
        .navigationTitle("Ara")
    }
}
