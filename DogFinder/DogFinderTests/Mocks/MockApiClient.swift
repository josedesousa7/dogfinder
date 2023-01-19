//
//  MockApiClient.swift
//  DogFinderTests
//
//  Created by José Marques on 18/01/2023.
//

import Foundation
@testable import DogFinder
import Combine

struct MockApiClient: DogFinderRequestsProtocol {

    private let requestManager: HttpProtocol

    init(requestManager: HttpProtocol = MockRequestManager()) {
        self.requestManager = requestManager
    }

    func fetchDogList<T>(page: Int) -> AnyPublisher<T, Error> where T : Decodable {
        return requestManager.fetch(RequestBuilder.buildUrlRequest())
            .map(\.value)
            .eraseToAnyPublisher()
    }
}
