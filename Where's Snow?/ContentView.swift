//
//  ContentView.swift
//  Where's Snow?
//
//  Created by Parth Antala on 2024-07-23.
//

import SwiftUI

@Observable
class Player {
    var name = "Paul"
    var highScore = 0
}

struct HighsScoreView: View {
    @Environment(Player.self) var player

    var body: some View {
        @Bindable var player = player
        Text("Score: \(player.highScore)")
        Stepper("High score: \(player.highScore)", value: $player.highScore)
    }
}
struct ContentView: View {

    @State private var player = Player()
    
    var body: some View {
        VStack {
            Text("Welcome")
            HighsScoreView()
        }
        .environment(player)
    }
}

#Preview {
    ContentView()
 
}


