//
//  PostsListViewModel.swift
//  Offsight-TH
//
//  Created by Vishal Singh on 04/02/21.
//

import Combine
import Foundation

protocol PostsListPresentable {
    var cellViewModels: [PostTableCellPresentable] { get set }
    
    var viewDelegate: PostsListViewDelegate? { get set }

    func fetcNextPage()
}

protocol PostsListViewDelegate: class {
    func viewModelDidFetchPosts(viewModel: PostsListPresentable)
}

class PostsListViewModel: PostsListPresentable {

    var cellViewModels: [PostTableCellPresentable] = []
    weak var viewDelegate: PostsListViewDelegate?

    private var subscriptions = Set<AnyCancellable>()
    private var currentPage = 0

    init() { }

    func fetcNextPage() {
        currentPage += 1
        let currentCount = cellViewModels.count
        DummyAPINetworkClient().getPosts(page: currentPage)
            .sink { completion in
                switch completion {
                // TODO: Handle error
                case .failure(let error): print(error.localizedDescription)
                case .finished: break
                }
            } receiveValue: { apiData in
                let newPosts = apiData.posts
                for (index, post) in newPosts.enumerated() {
                    self.cellViewModels.append(PostTableCellViewModel(with: post, index: index + currentCount))
                    self.viewDelegate?.viewModelDidFetchPosts(viewModel: self)
                }
            }
            .store(in: &subscriptions)
    }
}
