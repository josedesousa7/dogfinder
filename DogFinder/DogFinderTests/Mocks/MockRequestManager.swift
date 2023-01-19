//
//  MockRequestManager.swift
//  DogFinderTests
//
//  Created by José Marques on 18/01/2023.
//

import Foundation
@testable import DogFinder
import Combine

class MockRequestManager: HttpProtocol {

    func fetch<T>(_ request: URLRequest) -> AnyPublisher<DogFinder.Response<T>, Error> where T : Decodable {
        return Future { promise in
            promise(.success(self.getJsonObject()!))

        }.eraseToAnyPublisher()
    }
    
    private func getJsonObject<T>() -> Response<T>? where T : Decodable {
        let bundle = Bundle(for: MockRequestManager.self)
        guard
              let path = bundle.url(forResource: "response",withExtension: "json"),
              let data = try? Data(contentsOf: path),
              let value = try? JSONDecoder().decode(T.self, from: data) else {
            return nil
        }
        return Response(value: value,
                        response: nil)
    }
}
