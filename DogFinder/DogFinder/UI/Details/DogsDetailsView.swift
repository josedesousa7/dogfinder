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
            .padding()
            .navigationTitle("Details")
    }

    private var dogDetailsView: some View {
        GeometryReader { _ in
            VStack(alignment: .leading, spacing: 8) {
                dogsInfoView(title: "Breed name:",
                             body: dog.breedName)
                dogsInfoView(title: "Breed category:",
                             body: dog.category)
                dogsInfoView(title: "Origins from:",
                             body: dog.origin)
                dogsInfoView(title: "Temperament:",
                             body: dog.temperament)
            }
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 8)
                .stroke(Color(.systemGroupedBackground), lineWidth: 2.0))
        }
    }

    @ViewBuilder private func dogsInfoView(title: String,
                                           body: String) -> some View {
        HStack(alignment: .top) {
            Text(title)
                .font(.headline)
            Text(body)
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
