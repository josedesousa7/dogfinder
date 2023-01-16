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
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
            DogSearchView()
            .tabItem {
                Label("Order", systemImage: "square.and.pencil")
            }
        }
        .padding(.horizontal, 5)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
