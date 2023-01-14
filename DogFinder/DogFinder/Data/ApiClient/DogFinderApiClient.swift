//
//  DogFinderApiClient.swift
//  DogFinder
//
//  Created by José Marques on 14/01/2023.
//

import Foundation
import Combine

protocol DogFinderRequestsProtocol {
    func fetch<T: Decodable>() -> AnyPublisher<T, Error>
}

struct DogFinderApiClient: DogFinderRequestsProtocol {

    private let requestManager: HttpProtocol

    init(requestManager: HttpProtocol = RequestManager()) {
        self.requestManager = requestManager
    }

    func fetch<T: Decodable>() -> AnyPublisher<T, Error> {
        return requestManager.fetch(RequestBuilder.buildUrlRequest())
            .map(\.value)
            .eraseToAnyPublisher()
    }
}
