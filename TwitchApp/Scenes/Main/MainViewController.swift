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

    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
        initViews()
        bindViewModel()
        
        viewModel.initialize()
        viewModel.getData()
    }

    private func bindViewModel() {
        bind(viewModel.data) { [weak self] _ in self?.tableView.reloadData() }
    }
    
    private func initViews() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func rateTapped(_ sender: Any) {
        guard let viewController = R.storyboard.main.rateViewController() else { return }
        viewController.modalPresentationStyle = .overFullScreen
        present(viewController, animated: false)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItems()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.cell, for: indexPath)!.apply { $0.bind(item: viewModel.getItem(by: indexPath.row) ) }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == viewModel.numberOfItems() {
            viewModel.getData()
        }
    }
}
