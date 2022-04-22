//
//  FollowersViewController.swift
//  GithubFollowers
//
//  Created by Cem Nisan on 21.04.2022.
//

import UIKit

final class FollowersViewController: UIViewController {
    
    var viewModel: FollowersViewModelProtocol!
    
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
        
        Task { await viewModel.loadFollowers(pageNumber: 1) }
    }
}

// MARK: - Configure
extension FollowersViewController {
    
    private func configure() {
        configureViewController()
        configureViewModel()
    }
    
    private func configureViewController() {
        view.backgroundColor                                   = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        title                                                  = viewModel.username
    }
    
    private func configureViewModel() {
        viewModel.delegate   = self
    }
}

// MARK: - FollowersViewModel Delegate
extension FollowersViewController: FollowersViewModelDelegate {
    
    func handleOutput(output: FollowersViewModelOutput) {
        switch output {
        case .loadFollowers:
            print("ok?")
        case .requestError(let error):
            print(error)
        }
    }
}
