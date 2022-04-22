//
//  FollowersViewController.swift
//  GithubFollowers
//
//  Created by Cem Nisan on 21.04.2022.
//

import UIKit

final class FollowersViewController: UIViewController {
    
    private enum Section { case main }
    
    private var viewModel: FollowersViewModelProtocol!
    private var collectionView: UICollectionView!
    private var collectionViewDataSource: UICollectionViewDiffableDataSource<Section, FollowerPresentation>!
    
    init(viewModel: FollowersViewModelProtocol) {
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        
        Task { await viewModel.loadFollowers(pageNumber:1) }
    }
}

// MARK: - Configure
extension FollowersViewController {
    
    private func configure() {
        configureViewController()
        configureSearchController()
        configureViewModel()
        configureCollectionView()
        configureDataSource()
    }
    
    private func configureViewController() {
        view.backgroundColor                                   = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        title                                                  = viewModel.username
    }
    
    private func configureSearchController() {
        let searchController                                   = UISearchController()
        searchController.searchResultsUpdater                  = self
        searchController.searchBar.delegate                    = self
        searchController.searchBar.placeholder                 = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation  = false
        navigationItem.searchController                        = searchController
    }
    
    private func configureViewModel() {
        viewModel.delegate   = self
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds,
                                          collectionViewLayout: createThreeColumnFlowLayout())
        view.addSubview(collectionView)
        
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate        = self
        collectionView.register(FollowersCollectionViewCell.self,
                                forCellWithReuseIdentifier: FollowersCollectionViewCell.reuseID)
    }
    
    private func configureDataSource() {
        collectionViewDataSource = UICollectionViewDiffableDataSource<Section,
                                                                      FollowerPresentation>(collectionView: collectionView,
                                                                                            cellProvider: { collectionView, indexPath, follower in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowersCollectionViewCell.reuseID,
                                                          for: indexPath) as! FollowersCollectionViewCell
            cell.update(with: follower)
            
            return cell
        })
    }
}

// MARK: - Helpers
extension FollowersViewController {
    
    private func createThreeColumnFlowLayout() -> UICollectionViewFlowLayout {
        let width                       = view.bounds.width
        let padding: CGFloat            = 12
        let minumumItemSpacing: CGFloat = 10
        let availableWidth              = width - (padding * 2) - (minumumItemSpacing * 2)
        let itemWidth                   = availableWidth / 3
        
        let flowLayout                  = UICollectionViewFlowLayout()
        flowLayout.sectionInset         = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize             = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
    
    private func updateDataSource(on followers: [FollowerPresentation]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, FollowerPresentation>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        
        collectionViewDataSource.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: - FollowersViewModel Delegate
extension FollowersViewController: FollowersViewModelDelegate {
    
    func handleOutput(output: FollowersViewModelOutput) {
        
        switch output {
        case .loadFollowers(let followers):
            updateDataSource(on: followers)
        case .requestError(let error):
            print(error)
        }
    }
}

extension FollowersViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}

extension FollowersViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
    }
}

extension FollowersViewController: UICollectionViewDelegate {
    
}
