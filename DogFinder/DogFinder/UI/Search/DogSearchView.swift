//
//  DogSearchView.swift
//  DogFinder
//
//  Created by José Marques on 16/01/2023.
//

import SwiftUI

struct DogSearchView: View {
    @EnvironmentObject var viewModel: DogListViewModel
    @State private var searchText = ""
    var body: some View {
        NavigationStack {
            if viewModel.searchResults.isEmpty {
                noResultsView
            } else {
                searchResultsView
            }
        }
        .onChange(of: searchText, perform: { newValue in
            viewModel.filterResultsFor(newValue)
        })
        .searchable(text: $searchText, prompt: "Look for something")
    }

    private var noResultsView: some View {
        VStack {
            Spacer()
            Text("No results found")
                .navigationTitle("Search")
            Spacer()
        }
    }

    private var searchResultsView: some View {
        List {
            ForEach(viewModel.searchResults, id: \.name) { item in
                VStack(alignment: .leading, spacing: 8) {
                    Text("Name: " + item.name)
                    Text("Group: " + item.group)
                    Text("Origin: " + item.origin)
                }
            }
        }
        .navigationTitle("Search")
    }
}

struct DogSearchView_Previews: PreviewProvider {
    static var previews: some View {
        DogSearchView()
    }
}
