//
//  DogListRepository.swift
//  DogFinder
//
//  Created by José Marques on 14/01/2023.
//

import Foundation
import Combine

struct DogListRepository {

    private var apiClient: DogFinderRequestsProtocol

    init(apiClient: DogFinderRequestsProtocol = DogFinderApiClient()) {
        self.apiClient = apiClient
    }

    func dogList(page: Int) -> AnyPublisher<[Dog], Error> {
        apiClient.fetchDogList(page: page)
    }
}
