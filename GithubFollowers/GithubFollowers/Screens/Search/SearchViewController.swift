//
//  ViewController.swift
//  GithubFollowers
//
//  Created by Cem Nisan on 21.04.2022.
//

import UIKit
import GFComponents

final class SearchViewController: UIViewController {
    
    private let logoImageView    = GFImageView(image: K.Image.logoImage)
    private let searchTextField  = GFTextFields(placeholder: K.Title.searchPlaceholder)
    private let searchButton     = GFButton(backgrounColor: .systemGreen, title: K.Title.searchButtonTitle)
        
    var viewModel: SearchViewModel!
    
    private let padding: CGFloat = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        searchTextField.text = ""
        navigationController?.navigationBar.prefersLargeTitles = false
    }
}

// MARK: - Configure
extension SearchViewController {
    
    private func configure() {
        view.addSubviews(logoImageView, searchTextField, searchButton)
        
        configureViewController()
        configureViewModel()
        configureLogo()
        configureSearchTextField()
        configureSearchButton()
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureViewModel() {
        viewModel.delegate = self
    }
    
    private func configureLogo() {
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func configureSearchTextField() {
        searchTextField.delegate = self
        
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: padding),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            searchTextField.heightAnchor.constraint(equalToConstant: padding)
        ])
    }
    
    private func configureSearchButton() {
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            searchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            searchButton.heightAnchor.constraint(equalToConstant: padding)
        ])
    }
}

// MARK: - Button Tapped
extension SearchViewController {
    
    @objc
    private func searchButtonTapped() {
        guard !searchTextField.isUsernameEmpty else {
            presentGFAlertOnMainThread(title: "Something Went Wrong",
                                       message: "Please give a username?",
                                       buttonTitle: "OK")
            return
        }
        
        searchTextField.resignFirstResponder()
        viewModel.getFollowersButtonDidTapped(username: searchTextField.text!)
    }
}

// MARK: - SearchViewModel Delegate
extension SearchViewController: SearchViewModelDelegate {
    
    func navigate(to router: SearchViewModelRouter) {
        switch router {
        case .followers(let followersViewModel):
            let viewController = FollowersBuilder.build(with: followersViewModel)
            
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

// MARK: - UITextField Delegate
extension SearchViewController: UITextFieldDelegate {
  
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchButtonTapped()
        
        return true
    }
}
