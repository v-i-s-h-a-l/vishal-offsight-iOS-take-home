//
//  PostTableCellViewModel.swift
//  Offsight-TH
//
//  Created by Vishal Singh on 04/02/21.
//

import Foundation
//
//protocol PostTableCellPresentable: class {
//    var text: String { get set }
//    var imageURL: URL? { get set }
//    var numberOfLikes: Int { get set }
//    var isLiked: Bool { get set }
//    var detailsLink: URL? { get set }
//    var tags: [String] { get set }
//    var dateText: String { get set }
//    
//    var viewDelegate: PostTableCellViewDelegate? { get set }
//    
//    func handleLikeButtonTap()
//    func handleDetailDisclosureTap()
//}
//
//protocol PostTableCellViewDelegate: class {
//    func updateLike(count: Int, isLiked: Bool)
//}
//
//protocol PostTableCellDelegate: class {
//    func handleDetailDisclosureTap(for link: URL?)
//}
//
//class PostTableCellViewModel: PostTableCellPresentable {
//
//    var index: Int
//    var text: String
//    var imageURL: URL?
//    var numberOfLikes: Int
//    var detailsLink: URL?
//    var tags: [String]
//    var dateText: String
//    
//    weak var viewDelegate: PostTableCellViewDelegate?
//    weak var delegate: PostTableCellDelegate?
//
//    var isLiked = false
//        
//    init(with post: Post, index: Int) {
//        self.index = index
//        self.text = post.text ?? "Nothing to display here"
//        self.imageURL = URL(string: post.image ?? "")
//        self.numberOfLikes = post.likes ?? 0
//        self.detailsLink = URL(string: post.link ?? "")
//        self.tags = post.tags
//        if let date = DateHelper.date(from: post.publishDate) {
//            self.dateText = DateHelper.string(from: date)
//        } else {
//            self.dateText = "- -"
//        }
//    }
//
//    func handleLikeButtonTap() {
//        isLiked ? (numberOfLikes -= 1) : (numberOfLikes += 1)
//        isLiked.toggle()
//        viewDelegate?.updateLike(count: numberOfLikes, isLiked: isLiked)
//    }
//    
//    func handleDetailDisclosureTap() {
//        // TODO: send this action to main view model
//        // to handle it
//        delegate?.handleDetailDisclosureTap(for: detailsLink)
//    }
//}
