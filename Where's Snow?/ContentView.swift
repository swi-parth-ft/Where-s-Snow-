//
//  ContentView.swift
//  Where's Snow?
//
//  Created by Parth Antala on 2024-07-23.
//

import SwiftUI



struct ContentView: View {

    @State private var searchText = ""
    let allNames = ["Subh", "Vina", "Melvin", "Stefanie"]
    
    var filtered: [String] {
        if searchText.isEmpty {
            allNames
        } else {
            allNames.filter { name in
                name.localizedStandardContains(searchText)
            }
        }
    }
    var body: some View {
        NavigationStack {
            List(filtered, id: \.self) { name in
                Text(name)
            }
            .searchable(text: $searchText, prompt: "Look for something")
            
        }
    }
}

#Preview {
    ContentView()
 
}


