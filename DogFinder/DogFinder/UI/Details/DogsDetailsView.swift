//
//  DogsDetailsView.swift
//  DogFinder
//
//  Created by José Marques on 17/01/2023.
//

import SwiftUI

struct DogsDetailsView: View {
    let dog: DogListModel
    var body: some View {
        dogDetailsView
    }

    private var dogDetailsView: some View {
        VStack(alignment: .leading, spacing: .zero) {
            Text("Breed name: " + dog.breedName)
            Text("Breed category: " + dog.category)
            Text("Origins from: " + dog.origin)
            Text("Temperament: " + dog.temperament)
            Spacer()
        }
    }
}

struct DogsDetailsView_Previews: PreviewProvider {
    static var previews: some View {

        DogsDetailsView(dog: DogListModel(id: UUID().uuidString,
                                          breedName: "name",
                                          imageUrl: "mock",
                                          group: "mockGroup",
                                          origin: "mockOrigin",
                                          category: "mockCategory",
                                          temperament: "mockTemperament"))
    }
}
