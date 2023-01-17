//
//  DogListView.swift
//  DogFinder
//
//  Created by José Marques on 15/01/2023.
//

import SwiftUI
import Combine

struct DogListView: View {

    @EnvironmentObject var viewModel: DogListViewModel
    private var circle = Circle()
    private var rectangle = Rectangle()
    @State private var layoutFormat: LayoutFormat = .list
    var gridItems: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        if viewModel.state == .initialLoading {
            VStack {
                Spacer()
                ProgressView()
                Spacer()
            }
        } else {
            NavigationStack {
                VStack(alignment: .leading, spacing: .zero) {
                    formatChooser()
                        .padding(.horizontal, 16)
                    sortButton
                        .padding()
                    updatedLayout(items: viewModel.availableDogs)
                }
                .navigationTitle("Dogs 🐶")
            }
        }
    }

    @ViewBuilder private func gridView(items: [DogListModel]) -> some View {
        ScrollView {
            LazyVGrid(columns: gridItems, spacing: 10) {
                ForEach(items, id: \.id) { item in
                    NavigationLink {
                        DogsDetailsView(dog: item)
                    } label: {
                        VStack(spacing: 12) {
                            gridDogPicture(url: item.imageUrl)
                            dogName(item.breedName)
                            Spacer()
                        }
                        .onAppear() {
                            viewModel.loadMore(item: item)
                        }
                    }
                }
            }
        }
        .buttonStyle(.plain)
        .redacted(reason: viewModel.state.isLoading ? .placeholder: [])
    }

    @ViewBuilder private func listView(items: [DogListModel]) -> some View {
        List {
            ForEach(items, id: \.id) { item in
                NavigationLink {
                    DogsDetailsView(dog: item)
                } label: {
                    HStack(spacing: 12) {
                        listdogPicture(url: item.imageUrl)
                        dogName(item.breedName)
                        Spacer()
                    }
                    .onAppear() {
                        viewModel.loadMore(item: item)
                    }
                }

            }
            .frame(height: 100)
        }.redacted(reason: viewModel.state.isLoading ? .placeholder: [])
    }

    @ViewBuilder private func listdogPicture(url: String) -> some View {
        AsyncImage(
            url: URL(string: url),
            content: { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .overlay(circle
                        .stroke(.gray, lineWidth: 1)
                    )
            },
            placeholder: {
                Image(systemName: "photo")
            }
        )
    }

    @ViewBuilder private func gridDogPicture(url: String) -> some View {
        AsyncImage(
            url: URL(string: url),
            content: { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 150)
                    .clipShape(Rectangle())
                    .overlay(rectangle
                        .stroke(.gray, lineWidth: 1)
                    )
                    .cornerRadius(8)
            },
            placeholder: {
                Image(systemName: "photo")
            }
        )
        .padding()
    }

    @ViewBuilder private func dogName(_ name: String) -> some View {
        Text(name)
            .font(.subheadline)
            .padding(.horizontal, 8)
    }

    @ViewBuilder private func formatChooser() -> some View {
        Picker("", selection: $layoutFormat) {
            ForEach(LayoutFormat.allCases, id: \.self) { option in
                Text(option.rawValue)
            }
        }.pickerStyle(.segmented)
    }

    @ViewBuilder private func updatedLayout(items: [DogListModel]) -> some View {
        switch layoutFormat {
        case .list:
            listView(items: items)
        case .grid:
            gridView(items: items)
        }
    }

    private var sortButton: some View {
        HStack(alignment:.top, spacing: .zero) {
            Spacer()
            Button("Sort!") {
                viewModel.sortListOfdogs()
            }
            Spacer()
        }
    }

    private enum LayoutFormat:  String, CaseIterable {
        case list = "List"
        case grid = "Grid"
    }
}

struct DogListView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = DogListViewModel()
        DogListView()
            .environmentObject(viewModel)
    }
}
