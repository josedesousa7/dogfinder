//
//  MockApiClient.swift
//  DogFinderTests
//
//  Created by José Marques on 18/01/2023.
//

import Foundation
@testable import DogFinder
import Combine

struct MockRepository: DogListRepositoryProtocol {

    private var apiClient: DogFinderRequestsProtocol

    init(apiClient: DogFinderRequestsProtocol = MockApiClient()) {
        self.apiClient = apiClient
    }

    func dogList(page: Int) -> AnyPublisher<[Dog], Error> {
        apiClient.fetchDogList(page: page)
    }
}
