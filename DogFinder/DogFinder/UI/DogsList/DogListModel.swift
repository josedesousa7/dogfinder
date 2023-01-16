//
//  DogListModel.swift
//  DogFinder
//
//  Created by José Marques on 15/01/2023.
//

import Foundation

struct DogListModel: Hashable, Equatable {
    let id: String
    let name: String
    let imageUrl: String
    let group: String
    let origin: String 

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }

    static func == (lhs: DogListModel, rhs: DogListModel) -> Bool {
        return lhs.name == rhs.name && lhs.name == rhs.name
    }
}
