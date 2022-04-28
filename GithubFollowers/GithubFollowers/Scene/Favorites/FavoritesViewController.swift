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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
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
        title                = K.Title.favoritesNavTitle
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
      
        tableView.frame           = view.bounds
        tableView.rowHeight       = K.Styling.tableViewRowHeight
        tableView.tableFooterView = UIView()
        tableView.dataSource      = self
        tableView.delegate        = self
        tableView.register(FavoritesTableViewCell.self,
                           forCellReuseIdentifier: K.ReuseIDs.favoritesCellID)
    }
    
    private func configureViewModel() {
        viewModel.delegate = self
    }
}

// MARK: - Output
extension FavoritesViewController: FavoritesViewModelDelegate {
    
    func handleOutput(output: FavoritesViewModelOutput) {
        switch output {
        case .loadFavorites:
            DispatchQueue.main.async { self.tableView.reloadData() }
        }
    }
}

// MARK: - Navigate
extension FavoritesViewController {
    
    func navigate(to router: FavoritesViewModelRouter) {
        switch router {
        case .toFollowers(let followersViewModel):
            let viewController = FollowersViewController(viewModel: followersViewModel)
            
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

extension FavoritesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.ReuseIDs.favoritesCellID,
                                                 for: indexPath) as! FavoritesTableViewCell
        let favoriteCellViewModel = viewModel.favoriteCellViewModel(at: indexPath.row)
        cell.set(with: favoriteCellViewModel)
        
        return cell
    }
}

extension FavoritesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectedFavorite(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        viewModel.removeFavorite(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
    }
}
