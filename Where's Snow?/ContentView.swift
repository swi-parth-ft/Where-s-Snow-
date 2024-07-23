//
//  ContentView.swift
//  Where's Snow?
//
//  Created by Parth Antala on 2024-07-23.
//

import SwiftUI

struct UserView: View {
    var body: some View {
        Group {
            Text("Paul")
            Text("From England")
            Text("Pets: Luna and Arya")
        }
        .font(.title)
    }
}

struct ContentView: View {

    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        if horizontalSizeClass == .compact {
            VStack(content: UserView.init)
        } else {
            HStack(content: UserView.init)
        }
        
        
        ViewThatFits {
            Rectangle()
                .frame(width: 500, height: 200)
            
            Circle()
                .frame(width: 200)
        }
    }
}

#Preview {
    ContentView()
 
}


