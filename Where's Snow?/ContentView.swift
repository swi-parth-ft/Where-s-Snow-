//
//  ContentView.swift
//  Where's Snow?
//
//  Created by Parth Antala on 2024-07-23.
//

import SwiftUI

struct User: Identifiable {
    var id = "Paul Hudson"
}

struct ContentView: View {
    
    @State private var selectedUser: User? = nil
    @State private var isShowingAlert = false
    
    var body: some View {
        Button("Tap me") {
            selectedUser = User()
            isShowingAlert = true
        }
        .sheet(item: $selectedUser) { user in
            Text(user.id)
                .presentationDetents([.medium, .large])
        }
        .alert("Welcome", isPresented: $isShowingAlert, presenting: selectedUser) { user in
            Button(user.id) {}
        }
    }
}

#Preview {
    ContentView()
 
}


