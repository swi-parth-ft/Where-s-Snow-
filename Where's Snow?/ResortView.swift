//
//  ResortView.swift
//  Where's Snow?
//
//  Created by Parth Antala on 2024-07-23.
//

import SwiftUI

struct ResortView: View {
    let resort: Resort
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    @Environment(Favorites.self) var favorites
    
    @State private var selectedFacility: Facility?
    @State private var showingFacility = false
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [.white, .white, .cyan], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        Image(decorative: resort.id)
                            .resizable()
                            .scaledToFit()
                        
                        HStack {
                            if horizontalSizeClass == .compact && dynamicTypeSize > .large {
                                VStack(spacing: 10) {
                                    ResortDetailView(resort: resort)
                                }
                                VStack(spacing: 10) {
                                    SkiDetailView(resort: resort)
                                }
                            } else {
                                ResortDetailView(resort: resort)
                                SkiDetailView(resort: resort)
                            }
                        }
                        .padding(.vertical)
                        .background(.primary.opacity(0.1))
                        .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
                        
                        Group {
                            Text(resort.description)
                                .padding(.vertical)
                            
                            Text("Fecilities")
                                .font(.headline)
                            
                            HStack {
                                ForEach(resort.facilityTypes) { facility in
                                    Button {
                                        selectedFacility = facility
                                        showingFacility = true
                                    } label: {
                                        facility.icon
                                    }
                                }
                            }
                            .padding(.vertical)
                        }
                        .padding(.horizontal)
                    }
                    
                }
                .navigationTitle("\(resort.name), \(resort.country)")
                .navigationBarTitleDisplayMode(.inline)
                .alert(selectedFacility?.name ?? "More Information", isPresented: $showingFacility, presenting: selectedFacility) { _ in
                    
                } message: { facility in
                    Text(facility.description)
                }
                .toolbar {
                    Button(action: {
                        if favorites.contains(resort) {
                            favorites.remove(resort)
                        } else {
                            favorites.add(resort)
                        }
                    }) {
                        Image(systemName: favorites.contains(resort) ? "heart.fill" : "heart")
                            .foregroundColor(favorites.contains(resort) ? .red : .gray)
                    }
                }
            }
        }
    }
}

struct SkiDetailView: View {
    let resort: Resort
    var body: some View {
        Group {
            VStack {
                Text("Elevation")
                    .font(.caption.bold())
                Text("\(resort.elevation)m")
                    .font(.title3)
                
            }
            
            VStack {
                Text("Snow")
                    .font(.caption.bold())
                Text("\(resort.snowDepth)cm")
                    .font(.title3)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

struct ResortDetailView: View {
    let resort: Resort
    var size: String {
        switch resort.size {
        case 1: "small"
        case 2: "Average"
        default: "Large"
        }
    }
    
    var price: String {
        String(repeating: "$", count: resort.price)
    }
    
    var body: some View {
        Group {
            VStack {
                Text("Size")
                    .font(.caption.bold())
                Text(size)
                    .font(.title3)
                
            }
            
            VStack {
                Text("Price")
                    .font(.caption.bold())
                Text(price)
                    .font(.title3)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    ResortView(resort: .example)
        .environment(Favorites())
}
