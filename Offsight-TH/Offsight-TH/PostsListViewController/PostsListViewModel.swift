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
    var cellViewModels: [PostTableCellPresentable] { get set }
    
    var viewDelegate: PostsListViewDelegate? { get set }

    func fetcNextPage()
}

protocol PostsListViewDelegate: class {
    func viewModelDidFetchPosts(viewModel: PostsListPresentable, newIndexPaths: [IndexPath])
}

class PostsListViewModel: PostsListPresentable {

    var cellViewModels: [PostTableCellPresentable] = []
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
                for (index, post) in newPosts.enumerated() {
                    let cellViewModel = PostTableCellViewModel(with: post, index: index + currentCount)
                    cellViewModel.delegate = self
                    self.cellViewModels.append(cellViewModel)
                    self.viewDelegate?.viewModelDidFetchPosts(viewModel: self, newIndexPaths: newIndexPaths)
                }
            }
            .store(in: &subscriptions)
    }
}

extension PostsListViewModel: PostTableCellDelegate {
    
    func handleDetailDisclosureTap(for link: URL?) {
        // TODO: show alert to user
        guard let link = link else { return }
        UIApplication.shared.canOpenURL(link)
    }
}
