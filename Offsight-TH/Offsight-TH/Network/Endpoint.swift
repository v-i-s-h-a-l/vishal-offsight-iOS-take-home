//
//  Endpoint.swift
//  Offsight-TH
//
//  Created by Vishal Singh on 04/02/21.
//

import Foundation

enum Endpoint {
    case post

    var url: URL {
        // TODO: move it to a constants file
        let baseURL = "https://dummyapi.io/data/api/"
        let urlString = baseURL + path

        guard let url = URL(string: urlString) else { fatalError("Invalid URL: \(urlString)") }

        return url
    }
    
    var path: String {
        switch self {
        case .posts: return "/post"
        }
    }
    
    var header: [String: Any] {
        // TODO: move it to a constants file
        return ["app-id": "600e1a3c7bdbc316a88599a4"]
    }
}
