//
//  Breed.swift
//  DogFinder
//
//  Created by José Marques on 14/01/2023.
//

import Foundation

struct Breed: Codable {
    let id: Int?
    let name: String?
    let category: String?
    let group: String?
    let temperament: String?
    let origin: String?
    let imageId: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case category = "bred_for"
        case group = "breed_group"
        case temperament = "temperament"
        case imageId = "reference_image_id"
        case origin = "origin"
    }
}
