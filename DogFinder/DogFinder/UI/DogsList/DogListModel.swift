//
//  DogListModel.swift
//  DogFinder
//
//  Created by José Marques on 15/01/2023.
//

import Foundation

struct DogListModel: Hashable, Equatable {
    let name: String
    let imageUrl: String

    static func == (lhs: DogListModel, rhs: DogListModel) -> Bool {
     return lhs.name == rhs.name
    }
}
