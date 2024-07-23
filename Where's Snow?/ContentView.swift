//
//  ContentView.swift
//  Where's Snow?
//
//  Created by Parth Antala on 2024-07-23.
//

import SwiftUI
enum SortOrder: String, CaseIterable, Identifiable {
    case defaultOrder = "Default"
    case alphabetical = "Alphabetical"
    case runs = "Runs"
    
    var id: String { self.rawValue }
}
struct WelcomeView: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [.white, .cyan], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                Text("Welcome to Snow!")
                    .font(.largeTitle)
                
                Text("Please select a resort from the left-hand menu; swipe from the left edge to show it")
                    .foregroundStyle(.secondary)
                
            }}
    }
}

struct ContentView: View {
    
    
    let allResorts: [Resort] = Bundle.main.decode("resorts.json")
    @State private var sortOrder: SortOrder = .defaultOrder
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State private var searchText = ""
    
    var filteredResorts: [Resort] {
        
        let sortedResorts: [Resort]
        switch sortOrder { // Step 3: Apply sorting
        case .defaultOrder:
            sortedResorts = allResorts
        case .alphabetical:
            sortedResorts = allResorts.sorted { $0.name < $1.name }
        case .runs:
            sortedResorts = allResorts.sorted { $0.runs > $1.runs }
        }
        
        if searchText.isEmpty {
            return sortedResorts
        } else {
            return sortedResorts.filter { resort in
                resort.name.localizedStandardContains(searchText)
            }
        }
    }
    
    @State private var favorites = Favorites()
    
    var body: some View {
        NavigationSplitView {
            ZStack{
                LinearGradient(colors: [.white, .cyan], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                List(filteredResorts) { resort in
                    NavigationLink(value: resort) {
                        
                        HStack {
                            Image(resort.country)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 40, height: 25)
                                .clipShape(
                                    .rect(cornerRadius: 5)
                                )
                                .shadow(radius: 5)
                            
                            VStack(alignment: .leading) {
                                Text(resort.name)
                                    .font(.headline)
                                Text("\(resort.runs) runs")
                                    .foregroundStyle(.secondary)
                            }
                            
                            if favorites.contains(resort) {
                                Spacer()
                                Image(systemName: "heart.fill")
                                    .accessibilityLabel("This is a favorite resort")
                                    .foregroundStyle(.red)
                            }
                        }
                        
                        
                    }
                    .listRowBackground(horizontalSizeClass == .compact ? Color.white.opacity(0.5) : nil)
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Resorts")
            .navigationDestination(for: Resort.self) { resort in
                ResortView(resort: resort)
            }
            .searchable(text: $searchText, prompt: "Search for a resort")
            .toolbar {
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort Order", selection: $sortOrder) { // Add Picker
                        ForEach(SortOrder.allCases) { sortOrder in
                            Text(sortOrder.rawValue).tag(sortOrder)
                        }
                    }
                }
            }
        } detail: {
            WelcomeView()
        }
        .environment(favorites)
    }
}

#Preview {
    ContentView()
    
}


