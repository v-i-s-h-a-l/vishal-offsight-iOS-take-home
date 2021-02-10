//
//  PostDetailViewModel.swift
//  Offsight-TH
//
//  Created by Vishal Singh on 11/02/21.
//

import Foundation

protocol PostDetailDelegate: class {

    func handleDetailTap(for link: URL)
    func handleLikeTap(forPostId id: UUID, updatedIsLiked: Bool)
}

class PostDetailsViewModel: ObservableObject, Identifiable {

    let id: UUID

    let imageURL: URL?
    var numberOfLikes: Int
    @Published var isLiked: Bool
    let linkURL: URL?

    let text: String
    let publisherInfo: String
    let publishDateText: String
    let tags: [String]
    
    var delegate: PostDetailDelegate?
    
    init(with post: Post) {
        self.id = post.id
        self.imageURL = post.imageURL
        self.numberOfLikes = post.likes
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
        self.tags = post.tags
    }

    func onDetailTap() {
        guard let linkURL = linkURL else { return }
        delegate?.handleDetailTap(for: linkURL)
    }

    func onLikeButtonTap() {
        self.isLiked.toggle()
        delegate?.handleLikeTap(forPostId: id, updatedIsLiked: self.isLiked)
        if isLiked {
            numberOfLikes += 1
        } else {
            numberOfLikes -= 1
        }
    }
}
