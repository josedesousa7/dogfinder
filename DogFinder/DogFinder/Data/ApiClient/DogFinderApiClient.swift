//
//  DogFinderApiClient.swift
//  DogFinder
//
//  Created by José Marques on 14/01/2023.
//

import Foundation
import Combine

protocol DogFinderRequestsProtocol {
    func fetchDogList<T: Decodable>(page: Int) -> AnyPublisher<T, Error>
}

struct DogFinderApiClient: DogFinderRequestsProtocol {

    private let requestManager: HttpProtocol

    init(requestManager: HttpProtocol = RequestManager()) {
        self.requestManager = requestManager
    }

    func fetchDogList<T: Decodable>(page: Int) -> AnyPublisher<T, Error> {
        return requestManager.fetch(RequestBuilder.buildUrlRequest(page: page))
            .map(\.value)
            .eraseToAnyPublisher()
    }
}
