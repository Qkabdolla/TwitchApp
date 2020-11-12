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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
        initViews()
        bindViewModel()
        
        viewModel.initialize()
        viewModel.getData()
    }

    override func bindViewModel() {
        super.bindViewModel()
        bind(viewModel.data) { [weak self] _ in self?.tableView.reloadData() }
        
        rightBarItem.action { [weak self] in
            guard let viewController = R.storyboard.main.rateViewController() else { return }
            viewController.modalPresentationStyle = .overFullScreen
            self?.present(viewController, animated: false)
        }
    }
    
    private func initViews() {
        tableView.delegate = self
        tableView.dataSource = self
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
            viewModel.getData()
            viewModel.getMoreDataStatusCounter += 1
        }
    }
}
