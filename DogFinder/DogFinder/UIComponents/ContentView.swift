//
//  ContentView.swift
//  DogFinder
//
//  Created by José Marques on 14/01/2023.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var viewModel: DogListViewModel

    init(viewModel: DogListViewModel = DogListViewModel()) {
        self.viewModel = viewModel
    }
    var body: some View {
        TabView {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Hello, world!")
            }
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
