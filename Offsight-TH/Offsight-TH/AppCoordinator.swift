//
//  AppCoordinator.swift
//  Offsight-TH
//
//  Created by Vishal Singh on 11/02/21.
//

import Foundation
import SafariServices
import SwiftUI
import UIKit

class AppCoordinator {
    
    private weak var window: UIWindow!
    
    private var navigationController: UINavigationController!
    let postsListViewModel = PostsListViewModel()

    init(with window: UIWindow) {
        self.window = window
    }
    
    func start() {
        postsListViewModel.delegate = self
        navigationController = UINavigationController(rootViewController: PostsListViewController(with: postsListViewModel))
        navigationController.navigationBar.isTranslucent = false
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}

extension AppCoordinator: PostsListDelegate {

    func showDetails(for post: Post) {
        let swiftUIView = PostDetailView(viewModel: PostDetailsViewModel(with: post))
        let hostingController = UIHostingController(rootView: swiftUIView)
        navigationController.pushViewController(hostingController, animated: true)
    }
}

extension AppCoordinator: PostDetailDelegate {

    func handleDetailTap(forPostId: UUID) {
        // TODO: push safari vc
    }
    
    func handleLikeTap(forPostId: UUID, updatedIsLiked: Bool) {
        //
    }
}
