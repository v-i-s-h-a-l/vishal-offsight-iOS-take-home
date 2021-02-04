//
//  Endpoint.swift
//  Offsight-TH
//
//  Created by Vishal Singh on 04/02/21.
//

import Foundation

enum Endpoint {
    case post
    
    var urlRequest: URLRequest {
        var urlRequest = URLRequest(url: self.url)
        headers.forEach { (key, value) in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }

        return urlRequest
    }

    private var url: URL {
        let baseURL = Constant.baseURLString
        let urlString = baseURL + path

        guard let url = URL(string: urlString) else { fatalError("Invalid URL: \(urlString)") }

        return url
    }
    
    private var path: String {
        switch self {
        case .post: return "/post?limit=10"
        }
    }

    private var headers: [String: String] {
        return ["app-id": Constant.dummyAPIAppID]
    }
}
