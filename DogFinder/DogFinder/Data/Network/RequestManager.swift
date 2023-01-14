//
//  RequestManager.swift
//  DogFinder
//
//  Created by José Marques on 14/01/2023.
//

import Foundation
import Combine

protocol HttpProtocol {
    func fetch<T: Decodable>(_ request: URLRequest) -> AnyPublisher<Response<T>, Error>
}

struct RequestManager: HttpProtocol {
   private let session = URLSession.shared

    func fetch<T: Decodable>(_ request: URLRequest) -> AnyPublisher<Response<T>, Error> {
        return session
            .dataTaskPublisher(for: request)
            .tryMap { result -> Response<T> in
                let value = try JSONDecoder().decode(T.self, from: result.data)
                return Response(value: value, response: result.response)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

public struct Response<T> {
    let value: T
    let response: URLResponse
}
