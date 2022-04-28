//
//  FavoritesViewController.swift
//  GithubFollowers
//
//  Created by Cem Nisan on 21.04.2022.
//

import UIKit

final class FavoritesViewController: UIViewController {
    
    private let tableView = UITableView()
    
    private var viewModel: FavoritesViewModelProtocol!
    
    init(viewModel: FavoritesViewModelProtocol) {
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.loadFavorites()
    }
}

extension FavoritesViewController {
    
    private func configure() {
        configureViewController()
        configureTableView()
        configureViewModel()
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        title                = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
      
        tableView.frame           = view.bounds
        tableView.rowHeight       = 80
        tableView.tableFooterView = UIView()
        tableView.dataSource      = self
        tableView.delegate        = self
        tableView.register(FavoritesTableViewCell.self,
                           forCellReuseIdentifier: FavoritesTableViewCell.reuseID)
    }
    
    private func configureViewModel() {
        viewModel.delegate = self
    }
}

extension FavoritesViewController: FavoritesViewModelDelegate {
    
    func handleOutput(output: FavoritesViewModelOutput) {
        switch output {
        case .loadUser:
            DispatchQueue.main.async { self.tableView.reloadData() }
        }
    }
}

extension FavoritesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesTableViewCell.reuseID,
                                                 for: indexPath) as! FavoritesTableViewCell
        let favoriteCellViewModel = viewModel.favoriteCellViewModel(at: indexPath.row)
        cell.set(with: favoriteCellViewModel)
        
        return cell
    }
}

extension FavoritesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        viewModel.removeFavorites(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
    }
}
