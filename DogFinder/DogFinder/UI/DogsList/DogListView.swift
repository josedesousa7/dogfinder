//
//  DogListView.swift
//  DogFinder
//
//  Created by José Marques on 15/01/2023.
//

import SwiftUI
import Combine

struct DogListView: View {

    @ObservedObject var viewModel: DogListViewModel
    private var circle = Circle()
    private var rectangle = Rectangle()
    @State private var layoutFormat: LayoutFormat = .list
    var gridItems: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]

    init(viewModel: DogListViewModel = DogListViewModel()) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(spacing: .zero) {
            formatChooser()
                .padding(.horizontal, 16)
                .padding(.bottom, 8)
            updatedLayout(items: viewModel.availableDogs)
        }
    }

    @ViewBuilder private func gridView(items: [DogListModel]) -> some View {
        List {
            LazyVGrid(columns: gridItems, spacing: 10) {
                ForEach(items, id: \.name) { item in
                    VStack(spacing: 12) {
                        gridDogPicture(url: item.imageUrl)
                        dogName(item.name)
                        Spacer()
                    }
                }
            }
        }
        .redacted(reason: viewModel.state.isLoading ? .placeholder: [])
    }

    @ViewBuilder private func listView(items: [DogListModel]) -> some View {
        List {
            ForEach(items, id: \.name) { item in
                HStack(spacing: 12) {
                    listdogPicture(url: item.imageUrl)
                    dogName(item.name)
                    Spacer()
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
                    .frame(width: 80, height: 80)
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
    }

    @ViewBuilder private func dogName(_ name: String) -> some View {
        Text(name)
            .font(.subheadline)
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

    private enum LayoutFormat:  String, CaseIterable {
        case list = "List"
        case grid = "Grid"
    }
}

struct DogListView_Previews: PreviewProvider {
    static var previews: some View {
        DogListView()
    }
}
