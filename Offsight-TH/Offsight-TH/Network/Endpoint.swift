//
//  Endpoint.swift
//  Offsight-TH
//
//  Created by Vishal Singh on 04/02/21.
//

import Foundation

enum Endpoint {
    case post(page: Int, limit: Int = 10)
    
    var urlRequest: URLRequest {
        var urlRequest = URLRequest(url: self.url)
        urlRequest.httpMethod = "GET"
        headers.forEach { (key, value) in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }

        return urlRequest
    }

    private var url: URL {
        // TODO: break this down into URL components
        let baseURL = Constant.baseURLString
        let urlString = baseURL + path

        guard let url = URL(string: urlString) else { fatalError("Invalid URL: \(urlString)") }

        return url
    }
    
    private var path: String {
        switch self {
        case .post(let page, let limit): return "/post?page=\(page)&limit=\(limit)"
        }
    }

    private var headers: [String: String] {
        return ["app-id": Constant.dummyAPIAppID]
    }
}
