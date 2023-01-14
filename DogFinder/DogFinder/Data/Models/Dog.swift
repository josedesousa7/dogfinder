//
//  Dog.swift
//  DogFinder
//
//  Created by José Marques on 14/01/2023.
//

import Foundation

struct Dog: Codable {
    let id: String?
    let url: String?
    let width: Int?
    let height: Int?
    let breeds: [Breed]
}
