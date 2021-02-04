//
//  PostsListViewController.swift
//  Offsight-TH
//
//  Created by Vishal Singh on 04/02/21.
//

import UIKit

class PostsListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let cellName = String(describing: PostTableViewCell.self)

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.allowsSelection = false
            tableView.separatorStyle = .singleLine
            tableView.tableFooterView = UIView()
            tableView.rowHeight = UITableView.automaticDimension
            tableView.register(UINib(nibName: cellName, bundle: .main), forCellReuseIdentifier: cellName)
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
        // TODO: show loading on table
    }
    
    // MARK: - table view data source -
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.cellViewModels.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as! PostTableViewCell
        cell.configure(with: viewModel.cellViewModels[indexPath.row])

        return cell
    }

    // MARK: - table view delegate -
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        // TODO: add next page loafing
    }
}

extension PostsListViewController: PostsListViewDelegate {

    func viewModelDidFetchPosts(viewModel: PostsListPresentable) {
        DispatchQueue.main.async {
            self.tableView.reloadSections(IndexSet([0]), with: .automatic)
        }
    }
}
