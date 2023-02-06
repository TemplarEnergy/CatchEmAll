//
//  ContentView.swift
//  CatchEmAll
//
//  Created by Thomas Radford on 31/01/2023.
//

import SwiftUI

struct CreatureListView: View {
    var creatures = ["Pikachu", "Squirtle", "Charzard", "Snorlax"]
    var body: some View {
        NavigationStack {
            List(creatures, id: \.self) { creature in
                Text(creature)
                    .font(.title2)
                    
            }
            .listStyle(.plain)
            .navigationTitle("Pokemon")
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CreatureListView()
    }
}
