//
//  CompactPostCellViewModel.swift
//  Offsight-TH
//
//  Created by Vishal Singh on 11/02/21.
//

import Foundation

class CompactPostCellViewModel {

    let imageURL: URL?
    var numberOfLikes: Int = 0
    var isLiked: Bool
    let text: String
    let publisherText: String
    
    init(with post: Post) {
        self.imageURL = post.imageURL
        self.numberOfLikes = post.likes
        self.isLiked = post.isLiked
        self.text = post.text ?? "- -"
        self.publisherText = "by: \(post.owner?.firstName ?? "")"
    }
}
