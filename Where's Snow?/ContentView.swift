//
//  ContentView.swift
//  Where's Snow?
//
//  Created by Parth Antala on 2024-07-23.
//

import SwiftUI


struct ContentView: View {
    
    let allResorts: [Resort] = Bundle.main.decode("resorts.json")
    
    var body: some View {
        NavigationSplitView {
            List(allResorts ,id: \.self) { resort in
                NavigationLink(value: resort) {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(
                                .rect(cornerRadius: 5)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            )
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
        } detail: {
            Text("Detail")
        }
    }
}

#Preview {
    ContentView()
    
}


