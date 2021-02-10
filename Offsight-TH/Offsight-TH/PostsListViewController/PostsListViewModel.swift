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
}

protocol PostsListViewDelegate: class {
    func viewModelDidFetchPosts(viewModel: PostsListPresentable, newIndexPaths: [IndexPath])
}

class PostsListViewModel: PostsListPresentable {

    var cellViewModels: [CompactPostCellViewModel] = []
    weak var viewDelegate: PostsListViewDelegate?

    private var subscriptions = Set<AnyCancellable>()
    private var currentPage = 0
    private let limit = 10

    init() { }

    func fetcNextPage() {
        currentPage += 1
        let currentCount = cellViewModels.count
        let currentCellsCount = currentCount + 1 // (1 extra loading cell)
        let newIndexPaths = (currentCellsCount..<currentCellsCount+10).map { IndexPath(row: $0, section: 0) }
        DummyAPINetworkClient().getPosts(page: currentPage, limit: limit)
            .sink { completion in
                switch completion {
                // TODO: Handle error
                case .failure(let error): print(error.localizedDescription)
                case .finished: break
                }
            } receiveValue: { apiData in
                let newPosts = apiData.posts
                self.cellViewModels.append(contentsOf: newPosts.map { CompactPostCellViewModel(with: $0) })
                self.viewDelegate?.viewModelDidFetchPosts(viewModel: self, newIndexPaths: newIndexPaths)
            }
            .store(in: &subscriptions)
    }
}
