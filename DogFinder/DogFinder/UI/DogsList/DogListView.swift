//
//  DogListView.swift
//  DogFinder
//
//  Created by José Marques on 15/01/2023.
//

import SwiftUI

struct DogListView: View {

    @ObservedObject var viewModel: DogListViewModel
    private var shape = Circle()

    init(viewModel: DogListViewModel = DogListViewModel()) {
        self.viewModel = viewModel
    }

    var body: some View {
        List {
            ForEach(viewModel.availableDogs, id: \.name) { item in
                HStack(spacing: 12) {
                    dogPicture(url: item.imageUrl)
                    dogName(item.name)
                    Spacer()
                }
            }
            .frame(height: 100)
        }.redacted(reason: viewModel.state.isLoading ? .placeholder: [])
    }

    @ViewBuilder private func dogPicture(url: String) -> some View {
        AsyncImage(
            url: URL(string: url),
            content: { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80)
                    .clipShape(shape)
                    .overlay(shape
                            .stroke(.gray, lineWidth: 1)
                    )
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
}

struct DogListView_Previews: PreviewProvider {
    static var previews: some View {
        DogListView()
    }
}
