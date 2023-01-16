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
    let lifeSpan: String?
    let temperament: String?
    let imageId: String?
    let weight: MeasurementSystem
    let height: MeasurementSystem

    enum CodingKeys: String, CodingKey {

        case weight = "weight"
        case height = "height"
        case id = "id"
        case name = "name"
        case category = "bred_for"
        case group = "breed_group"
        case lifeSpan = "life_span"
        case temperament = "temperament"
        case imageId = "reference_image_id"
    }
}
