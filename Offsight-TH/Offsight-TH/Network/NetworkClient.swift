//
//  NetworkClient.swift
//  Offsight-TH
//
//  Created by Vishal Singh on 04/02/21.
//

import Combine
import Foundation

final class DummyAPINetworkClient {
    
    func getPosts(page: Int, limit: Int) -> AnyPublisher<DummyAPIData, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: Endpoint.post(page: page, limit: limit).urlRequest)
            .map(\.data)
            .decode(type: DummyAPIData.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
