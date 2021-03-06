//
//  PostsListViewController.swift
//  Offsight-TH
//
//  Created by Vishal Singh on 04/02/21.
//

import UIKit

class PostsListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let postCellName = String(describing: CompactPostTableViewCell.self)
    private let loadingCellName = String(describing: LoadingIndicatorTableViewCell.self)

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.separatorStyle = .singleLine
            tableView.tableFooterView = UIView()
            tableView.rowHeight = UITableView.automaticDimension
            tableView.register(UINib(nibName: postCellName, bundle: .main), forCellReuseIdentifier: postCellName)
            tableView.register(UINib(nibName: loadingCellName, bundle: .main), forCellReuseIdentifier: loadingCellName)
        }
    }
    
    var viewModel: PostsListPresentable!

    private var selectedIndexPath: IndexPath?
    
    init(with viewModel: PostsListPresentable) {
        self.viewModel = viewModel
        
        super.init(nibName: String(describing: Self.self), bundle: .main)
        
        self.viewModel.viewDelegate = self
        self.title = "Posts"
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.fetcNextPage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel.onViewWillAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if let selectedIndexPath = selectedIndexPath {
            tableView.deselectRow(at: selectedIndexPath, animated: true)
        }
    }
    
    // MARK: - table view data source -
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel?.cellViewModels.count ?? 0) + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == (viewModel?.cellViewModels.count ?? 0) {
            return tableView.dequeueReusableCell(withIdentifier: loadingCellName, for: indexPath)
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: postCellName, for: indexPath) as! CompactPostTableViewCell
        cell.configure(with: viewModel.cellViewModels[indexPath.row])

        return cell
    }
    
    // MARK: - table view delegate -

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let _ = cell as? LoadingIndicatorTableViewCell {
            viewModel.fetcNextPage()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        viewModel.handleRowTap(at: indexPath.row)
    }
    
//    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        // TODO: test it once APIs get working
//        guard indexPath.row < viewModel.cellViewModels.count else { return nil }
//        return indexPath
//    }
}

extension PostsListViewController: PostsListViewDelegate {

    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
