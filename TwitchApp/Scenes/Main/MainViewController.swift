//
//  ViewController.swift
//  TwitchApp
//
//  Created by Kabdolla on 11/3/20.
//

import UIKit
import RxSwift
import RxCocoa

final class MainViewController: MvvmViewController<MainViewModel> {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var rightBarItem: UIBarButtonItem!
    
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        bindViewModel()
        
        viewModel.initialize()
    }

    override func bindViewModel() {
        super.bindViewModel()
        bind(viewModel.data) { [weak self] _ in
            self?.tableView.reloadData()
            self?.refreshControl.endRefreshing()
        }
        
        bind(viewModel.launchRatingScreenCommand) { [weak self] in
            guard let viewController = R.storyboard.main.rateViewController() else { return }
            viewController.modalPresentationStyle = .overFullScreen
            self?.present(viewController, animated: false)
        }
        
        bind(viewModel.refreshing, to: refreshControl)
    }
    
    private func initViews() {
        tableView.refreshControl = refreshControl
        
        rightBarItem.action { [weak self] in
            self?.viewModel.didTapRatingButton()
        }
        
        setupRefresher(and: refreshControl, for: tableView, using: #selector(refreshingStarted))
    }
    
    @objc private func refreshingStarted() {
        viewModel.refreshData()
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItems()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.cell, for: indexPath)!.apply {
            $0.bind(item: viewModel.getItem(by: indexPath.row)) }
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y > scrollView.contentSize.height * 0.60 {
            viewModel.didScrollToBottom()
        }
    }
}
