//
//  DogListView.swift
//  DogFinder
//
//  Created by José Marques on 15/01/2023.
//

import SwiftUI

struct DogListView: View {

    @ObservedObject var viewModel: DogListViewModel

    init(viewModel: DogListViewModel = DogListViewModel()) {
        self.viewModel = viewModel
    }

    var body: some View {
        List {
            ForEach(viewModel.availableDogs, id: \.name) { item in
                AsyncImage(
                    url: URL(string: item.imageUrl),
                    content: { image in
                        image.resizable()
                             .aspectRatio(contentMode: .fit)
                             .frame(maxWidth: 80, maxHeight: 80)
                    },
                    placeholder: {
                        ProgressView()
                    }
                )
            }
        }.redacted(reason: viewModel.state.isLoading ? .placeholder: [])
    }
}

struct DogListView_Previews: PreviewProvider {
    static var previews: some View {
        DogListView()
    }
}
