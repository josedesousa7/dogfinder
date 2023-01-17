//
//  DogListModel.swift
//  DogFinder
//
//  Created by José Marques on 15/01/2023.
//

import Foundation

struct DogListModel: Hashable, Equatable {
    let id: String
    let breedName: String
    let imageUrl: String
    let group: String
    let origin: String
    let category: String
    let temperament: String

    func hash(into hasher: inout Hasher) {
        hasher.combine(breedName)
    }

    static func == (lhs: DogListModel, rhs: DogListModel) -> Bool {
        return lhs.breedName == rhs.breedName && lhs.breedName == rhs.breedName
    }
}
