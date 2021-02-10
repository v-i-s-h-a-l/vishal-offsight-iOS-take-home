//
//  Post.swift
//  Offsight-TH
//
//  Created by Vishal Singh on 04/02/21.
//

import Foundation

struct DummyAPIData: Codable {
    private(set) var posts: [Post]
    
    enum CodingKeys: String, CodingKey {
        case posts = "data"
    }
}

struct Post: Codable, Identifiable {

    let id = UUID()
    
    private(set) var text: String?
    private(set) var imageURL: URL?

    // not keeping private(set) for likes
    // as we are locally updating the value
    // and not using network calls for this
    var likes: Int
    var isLiked: Bool = false

    private(set) var linkURL: URL?
    private(set) var tags: [String]
    private(set) var publishDate: Date?
    private(set) var owner: User?
    
    private enum CodingKeys: String, CodingKey {
        case text
        case imageURL = "image"
        case likes
        case linkURL = "link"
        case tags
        case publishDate
        case owner
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        text = try container.decodeIfPresent(String.self, forKey: .text)
        imageURL = try container.decodeIfPresent(URL.self, forKey: .imageURL)
        likes = (try? container.decodeIfPresent(Int.self, forKey: .likes)) ?? 0
        linkURL = try container.decodeIfPresent(URL.self, forKey: .linkURL)
        tags = (try? container.decodeIfPresent([String].self, forKey: .tags)) ?? []
        let dateString = try container.decode(String.self, forKey: .publishDate)
        if let date = DateHelper.apiDate(from: dateString) {
            publishDate = date
        } else {
            throw DecodingError.dataCorruptedError(forKey: .publishDate,
                  in: container,
                  debugDescription: "Date string does not match format expected by formatter.")
        }

        owner = try container.decodeIfPresent(User.self, forKey: .owner)
    }

    mutating func updateIsLiked(to updatedIsLiked: Bool) {
        self.isLiked = updatedIsLiked
        if self.isLiked {
            likes += 1
        } else {
            likes -= 1
        }
    }

    private init() {
        text = "This is a dummy text."
        owner = User(id: nil, firstName: "First", lastName: "Last", picture: nil, location: Location(state: "New Delhi", country: "India"))
        likes = 5
        publishDate = Date()
        tags = [1..<5].map { "Duumy \($0)" }
    }

    static func dummy() -> Post {
        return Post()
    }
}

struct User: Codable {

    private(set) var id: String?
    private(set) var title: String?
    private(set) var firstName: String?
    private(set) var lastName: String?
    private(set) var picture: URL?
    private(set) var location: Location?
    // ignoring other values for now
}

struct Location: Codable {
    
    private(set) var state: String?
    private(set) var country: String?
    // ignoring other values for now
}
