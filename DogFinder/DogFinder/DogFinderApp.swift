//
//  DogFinderApp.swift
//  DogFinder
//
//  Created by José Marques on 14/01/2023.
//

import SwiftUI

@main
struct DogFinderApp: App {
    let viewModel = DogListViewModel()
    var body: some Scene {
        WindowGroup {
            TabView {
                DogListView()
                    .tabItem {
                        Label("Menu", systemImage: "list.dash")
                    }
                    .environmentObject(viewModel)
                DogSearchView()
                    .environmentObject(viewModel)
                .tabItem {
                    Label("Order", systemImage: "square.and.pencil")
                }
            }
            .padding(.horizontal, 5)
        }
    }
}
