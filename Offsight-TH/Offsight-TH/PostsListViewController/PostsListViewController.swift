//
//  PostsListViewController.swift
//  Offsight-TH
//
//  Created by Vishal Singh on 04/02/21.
//

import UIKit

class PostsListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let postCellName = String(describing: PostTableViewCell.self)
    private let loadingCellName = String(describing: LoadingIndicatorTableViewCell.self)

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.allowsSelection = false
            tableView.separatorStyle = .singleLine
            tableView.tableFooterView = UIView()
            tableView.rowHeight = UITableView.automaticDimension
            tableView.register(UINib(nibName: postCellName, bundle: .main), forCellReuseIdentifier: postCellName)
            tableView.register(UINib(nibName: loadingCellName, bundle: .main), forCellReuseIdentifier: loadingCellName)
        }
    }
    
    var viewModel: PostsListPresentable!
    
    init(with viewModel: PostsListPresentable) {
        self.viewModel = viewModel
        
        super.init(nibName: String(describing: Self.self), bundle: .main)
        
        self.viewModel.viewDelegate = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.fetcNextPage()
    }
    
    // MARK: - table view data source -
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel?.cellViewModels.count ?? 0) + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == (viewModel?.cellViewModels.count ?? 0) {
            return tableView.dequeueReusableCell(withIdentifier: loadingCellName, for: indexPath)
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: postCellName, for: indexPath) as! PostTableViewCell
        cell.configure(with: viewModel.cellViewModels[indexPath.row])

        return cell
    }
    
    // MARK: - table view delegate -

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let _ = cell as? LoadingIndicatorTableViewCell {
            viewModel.fetcNextPage()
        }
    }
}

extension PostsListViewController: PostsListViewDelegate {
    func viewModelDidFetchPosts(viewModel: PostsListPresentable, newIndexPaths: [IndexPath]) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
