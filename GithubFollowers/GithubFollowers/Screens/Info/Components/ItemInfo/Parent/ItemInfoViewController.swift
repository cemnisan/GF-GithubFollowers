//
//  ItemInfoViewController.swift
//  GithubFollowers
//
//  Created by Cem Nisan on 23.04.2022.
//

import UIKit
import GFComponents

class ItemInfoViewController: UIViewController {
    
    private let stackView   = UIStackView()
    let itemInfoViewOne     = GFItemInfoView()
    let itemInfoViewTwo     = GFItemInfoView()
    let itemActionButton    = GFButton()
    
    var user: UserInfoPresentation!
    
    init(user: UserInfoPresentation) {
        super.init(nibName: nil, bundle: nil)
        
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
}

extension ItemInfoViewController {
    
    private func configure() {
        configureViewController()
        configureStackView()
        layoutUI()
        configureActionButton()
    }
    
    private func configureViewController() {
        view.layer.cornerRadius = 18
        view.backgroundColor    = .secondarySystemBackground
    }
    
    private func configureStackView() {
        stackView.axis  = .horizontal
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        [itemInfoViewOne, itemInfoViewTwo].forEach { stackView.addArrangedSubview($0) }
    }
    
    private func layoutUI() {
        view.addSubviews(itemActionButton, stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureActionButton() {
        itemActionButton.addTarget(self, action: #selector(itemActionButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            itemActionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            itemActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            itemActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            itemActionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}

// MARK: - Button Tapped
extension ItemInfoViewController {
    
    @objc
    func itemActionButtonTapped() {}
}
