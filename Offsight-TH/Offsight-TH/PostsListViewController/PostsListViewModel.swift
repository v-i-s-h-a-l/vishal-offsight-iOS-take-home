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
    
    var viewDelegate: PostsListViewDelegate? { get set }

    func fetcNextPage()
    func handleRowTap(at index: Int)
}

protocol PostsListViewDelegate: class {
    func viewModelDidFetchPosts(viewModel: PostsListPresentable)
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

    init() { }

    func fetcNextPage() {
        guard !isLoading, currentPage < 3 else { return }

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
                self.viewDelegate?.viewModelDidFetchPosts(viewModel: self)
            }
            .store(in: &subscriptions)
    }

    func handleRowTap(at index: Int) {
        delegate?.showDetails(for: posts[index])
    }
}
