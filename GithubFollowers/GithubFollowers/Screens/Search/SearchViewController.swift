//
//  ViewController.swift
//  GithubFollowers
//
//  Created by Cem Nisan on 21.04.2022.
//

import UIKit
import GFComponents

final class SearchViewController: UIViewController {
    
    let logoImageView    = GFImageView(image: K.Image.logoImage)
    let searchTextField  = GFTextFields(frame: .zero)
    let searchButton     = GFButton(backgrounColor: .systemGreen, title: K.Title.searchButtonTitle)
    
    let padding: CGFloat = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
}

extension SearchViewController {
    
    private func configure() {
        view.addSubviews(logoImageView, searchTextField, searchButton)
        
        configureViewController()
        configureLogo()
        configureSearchTextField()
        configureSearchButton()
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
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
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: padding),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            searchTextField.heightAnchor.constraint(equalToConstant: padding)
        ])
    }
    
    private func configureSearchButton() {
        NSLayoutConstraint.activate([
            searchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            searchButton.heightAnchor.constraint(equalToConstant: padding)
        ])
    }
}
