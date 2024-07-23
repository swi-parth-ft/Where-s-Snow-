//
//  ContentView.swift
//  Where's Snow?
//
//  Created by Parth Antala on 2024-07-23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationSplitView(columnVisibility: .constant(.all)) {
            List {
                NavigationLink("Primary") {
                    Text("New View")
                }
                
                NavigationLink("Primary 2") {
                    Text("New View 2")
                }
            }
        } detail: {
            Text("Content")
        }
        .navigationSplitViewStyle(.prominentDetail)
    }
}

#Preview {
    ContentView()
 
}


