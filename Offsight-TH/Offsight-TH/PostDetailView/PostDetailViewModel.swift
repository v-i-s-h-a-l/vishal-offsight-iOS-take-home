//
//  PostDetailViewModel.swift
//  Offsight-TH
//
//  Created by Vishal Singh on 11/02/21.
//

import Foundation

class PostDetailsViewModel: ObservableObject, Identifiable {

    let id: UUID

    let imageURL: URL?
    let numberOfLikes: Int
    @Published var isLiked: Bool
    let linkURL: URL?

    let text: String
    let publisherInfo: String
    let publishDateText: String
    
    init(with post: Post) {
        self.id = post.id
        self.imageURL = post.imageURL
        self.numberOfLikes = post.likes ?? 0
        self.isLiked = post.isLiked
        self.linkURL = post.linkURL
        self.text = post.text ?? ""
        let owner = post.owner
        self.publisherInfo = "by: \(owner?.title ?? "") \(owner?.firstName ?? "") \(owner?.lastName ?? "")"
        if let date = post.publishDate {
            publishDateText = DateHelper.string(from: date)
        } else {
            publishDateText = ""
        }
    }
}
