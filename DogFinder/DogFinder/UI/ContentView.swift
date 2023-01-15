//
//  ContentView.swift
//  DogFinder
//
//  Created by José Marques on 14/01/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            DogListView()
                .padding()
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }

            VStack {
                Text("Test")
                Text("Hello, world!")
            }
            .padding()

            .tabItem {
                Label("Order", systemImage: "square.and.pencil")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
