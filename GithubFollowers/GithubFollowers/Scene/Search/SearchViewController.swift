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
    private let searchTextField  = GFTextFields(placeholder: K.Search.searchPlaceholder)
    private let searchButton     = GFButton(backgrounColor: .systemGreen, title: K.Title.searchButtonTitle)
        
    var viewModel: SearchViewModel!
        
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
        view.addSubviews(logoImageView,
                         searchTextField,
                         searchButton)
        configureViewController()
        configureLogo()
        configureSearchTextField()
        configureSearchButton()
        configureViewModel()
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureLogo() {
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: K.Styling.logoImageTopAnchor),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: K.Styling.logoImageSize),
            logoImageView.heightAnchor.constraint(equalToConstant: K.Styling.logoImageSize)
        ])
    }
    
    private func configureSearchTextField() {
        searchTextField.delegate = self
        
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: K.Styling.maxPadding),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: K.Styling.maxPadding),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -K.Styling.maxPadding),
            searchTextField.heightAnchor.constraint(equalToConstant: K.Styling.maxPadding)
        ])
    }
    
    private func configureSearchButton() {
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            searchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -K.Styling.maxPadding),
            searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: K.Styling.maxPadding),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -K.Styling.maxPadding),
            searchButton.heightAnchor.constraint(equalToConstant: K.Styling.maxPadding)
        ])
    }
    
    private func configureViewModel() {
        viewModel.delegate = self
    }
}

// MARK: - Button Tapped
extension SearchViewController {
    
    @objc
    private func searchButtonTapped() {
        guard !searchTextField.isUsernameEmpty else {
            presentGFAlertOnMainThread(title: K.Alert.SearchError.title,
                                       message: K.Alert.SearchError.message,
                                       buttonTitle: K.Alert.SearchError.buttonTitle)
            return
        }
        searchTextField.resignFirstResponder()
        viewModel.searchButtonDidTapped(username: searchTextField.text!)
    }
}

// MARK: - SearchViewModel Router
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
