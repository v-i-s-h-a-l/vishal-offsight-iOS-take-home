//
//  PostsListViewModel.swift
//  Offsight-TH
//
//  Created by Vishal Singh on 04/02/21.
//

import Combine
import Foundation
import UIKit

protocol PostsListPresentable {
    var cellViewModels: [CompactPostCellViewModel] { get set }
    var onViewWillAppear: (() -> ()) { get set }
    
    var viewDelegate: PostsListViewDelegate? { get set }

    func fetcNextPage()
    func handleRowTap(at index: Int)
}

protocol PostsListViewDelegate: class {
    func reloadData()
}

protocol PostsListDelegate: class {
    func showDetails(for post: Post)
}

class PostsListViewModel: PostsListPresentable {

    var cellViewModels: [CompactPostCellViewModel] = []
    weak var viewDelegate: PostsListViewDelegate?
    var delegate: PostsListDelegate?

    private var posts: [Post] = []
    private var isLoading = false
    private var subscriptions = Set<AnyCancellable>()
    private var currentPage = 1
    private let limit = 10

    var onViewWillAppear: (() -> ()) = {}

    init() { }

    func fetcNextPage() {
        guard !isLoading else { return }

        isLoading = true
        DummyAPINetworkClient().getPosts(page: currentPage, limit: limit)
            .sink { completion in
                self.isLoading = false
                switch completion {
                // TODO: Handle error
                case .failure(let error): print(error.localizedDescription)
                case .finished: break
                }
            } receiveValue: { apiData in
                self.currentPage += 1
                let newPosts = apiData.posts
                self.posts.append(contentsOf: newPosts)
                self.cellViewModels.append(contentsOf: newPosts.map { CompactPostCellViewModel(with: $0) })
                self.viewDelegate?.reloadData()
            }
            .store(in: &subscriptions)
    }

    func handleRowTap(at index: Int) {
        guard index < cellViewModels.count else {
            return
        }
        onViewWillAppear = {}
        delegate?.showDetails(for: posts[index])
    }

    func updateLikeStatus(for postID: UUID, updateIsLiked: Bool) {
        if let index = posts.firstIndex(where: { $0.id == postID }) {
            posts[index].updateIsLiked(to: updateIsLiked)
            cellViewModels[index].updateIsLiked(to: updateIsLiked)
        }
        
        onViewWillAppear = { self.viewDelegate?.reloadData() }
    }
}
