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
    private var searchController: UISearchController!
    
    init(viewModel: FollowersViewModelProtocol) {
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel = viewModel
        title          = viewModel.username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        bindFollowers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
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
    }
    
    private func configureSearchController() {
        searchController                                       = UISearchController()
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
        collectionViewDataSource = UICollectionViewDiffableDataSource<Section, FollowerPresentation>(collectionView: collectionView,
                                                                                                     cellProvider: { collectionView, indexPath, follower in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowersCollectionViewCell.reuseID,
                                                          for: indexPath) as! FollowersCollectionViewCell
            cell.update(with: follower)
            
            return cell
        })
    }
}

// MARK: - View Helpers
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
        
        DispatchQueue.main.async { self.collectionViewDataSource.apply(snapshot, animatingDifferences: true) }
    }
    
    private func updateView(if isFollowersEmpty: Bool) {
        if isFollowersEmpty {
            let message = "This doesn't have any followers. Go follow them."
            DispatchQueue.main.async { self.showEmptyStateView(with: message, in: self.view) }
            return
        }
    }
}

// MARK: - FollowersViewModel Output
extension FollowersViewController: FollowersViewModelDelegate {
    
    func handleOutput(output: FollowersViewModelOutput) {
        
        switch output {
        case .isLoading(let isLoading):
            isLoading ? showLoadingIndicator() : dissmisLoadingIndicator()
            
        case .loadFollowers(let followers):
            updateView(if: viewModel.isFollowersEmpty)
            updateDataSource(on: followers)
            
        case .filterableFollowers(let followers):
            updateDataSource(on: followers)
            
        case .requestError(let error):
            presentGFAlertOnMainThread(title: "Something went wrong",
                                       message: error.localizedDescription,
                                       buttonTitle: "OK")
        }
    }
}

// MARK: - FollowersViewModel Router
extension FollowersViewController {
    
    func navigate(to router: FollowersViewModelRouter) {
        
        switch router {
        case .userInfo(let viewModel):
            let viewController = UserInfoBuilder.build(with: viewModel, delegate: self)
            searchController.isActive = false
            show(viewController, sender: nil)
        }
    }
}

// MARK: - UISearchResults
extension FollowersViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard searchController.isSearching else {
            viewModel.filterFollowersIfSearching(isSearching: false, searchText: nil)
            return
        }
        viewModel.filterFollowersIfSearching(isSearching: true, searchText: searchController.searchBar.text)
    }
}

// MARK: - USearchBar Delegate
extension FollowersViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.filterFollowersIfSearching(isSearching: false, searchText: nil)
    }
}

// MARK: - UICollectionView Delegate
extension FollowersViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        viewModel.selectedFollower(index: indexPath.item, isSearching: searchController.isSearching)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView,
                                  willDecelerate decelerate: Bool) {
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let height          = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard !viewModel.hasMoreFollowers else { return }
            
            viewModel.pageNumber += 1
            bindFollowers()
        }
    }
}

// MARK: - UserInfoViewController Delegate
extension FollowersViewController: UserInfoViewControllerDelegate {
    
    func didRequestUserFollwers(for username: String) {
        viewModel.username            = username
        title                         = username
        viewModel.followersDidLoad()
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        
        bindFollowers()
    }
}

// MARK: - Bind Data
extension FollowersViewController {
    
    private func bindFollowers() {
        Task(priority: .background) { await viewModel.loadFollowers() }
    }
}
