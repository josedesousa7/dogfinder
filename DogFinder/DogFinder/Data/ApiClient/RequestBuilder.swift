//
//  RequestBuilder.swift
//  DogFinder
//
//  Created by José Marques on 14/01/2023.
//

import Foundation

enum RequestBuilder {
    private static func buildURL() -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.thedogapi.com"
        components.path = "/v1/images/search"
        components.queryItems = [
            URLQueryItem(name: "has_breeds", value: "true"),
            URLQueryItem(name: "limit", value: "10"),
            URLQueryItem(name: "size", value: "thumb")
        ]
        return components.url!
    }

    static func buildUrlRequest() -> URLRequest {
        var urlRequest = URLRequest(url: buildURL())
        urlRequest.setValue("live_6Y7wbtQi4GxlEmkX50za8TM4KcwpPxkRhfMPP8kT6twIkKJ5XVQTPaUz8DY1fTju", forHTTPHeaderField: "x-api-key")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return urlRequest
    }
}
