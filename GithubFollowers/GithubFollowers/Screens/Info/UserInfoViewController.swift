//
//  UserInfoViewController.swift
//  GithubFollowers
//
//  Created by Cem Nisan on 22.04.2022.
//

import UIKit
import GFComponents

final class UserInfoViewController: UIViewController {
    
    private let scrollView        = UIScrollView()
    private let contentView       = UIView()
    
    private let headerView        = UIView()
    private let userFollowersView = UIView()
    private let userReposViwe     = UIView()
    private let dateLabel         = GFBodyLabel(textAlignment: .center)
    
    private var viewModel: UserInfoViewModelProtocol!
    
    init(viewModel: UserInfoViewModelProtocol) {
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        bindUserInfo()
    }
}

// MARK: - Configure
extension UserInfoViewController {
    
    private func configure() {
        configureViewController()
        configureScrollView()
        layoutUI()
        configureViewModel()
    }
    
    private func configureViewController() {
        view.backgroundColor                = .systemBackground
        let doneButton                      = UIBarButtonItem(barButtonSystemItem: .done,
                                                              target: self,
                                                              action: #selector(dismissViewController))
        navigationItem.rightBarButtonItem   = doneButton
    }
    
    private func layoutUI() {
        [headerView,
         userReposViwe,
         userFollowersView,
         dateLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                $0.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
            ])
        }
        
        userReposViwe.backgroundColor = .systemBlue
        userFollowersView.backgroundColor = .systemRed
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 210),
            
            userReposViwe.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            userReposViwe.heightAnchor.constraint(equalToConstant: 140),
            
            userFollowersView.topAnchor.constraint(equalTo: userReposViwe.bottomAnchor, constant: 20),
            userFollowersView.heightAnchor.constraint(equalToConstant: 140),
            
            dateLabel.topAnchor.constraint(equalTo: userFollowersView.bottomAnchor, constant: 20),
            dateLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureUIElements(with user: UserInfoPresentation) {
        let headerViewController = UserInfoHeaderViewController(user: user)
        
        add(childVC: headerViewController, to: self.headerView)
    }
    
    private func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.pinToEdges(of: view)
        contentView.pinToEdges(of: scrollView)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 600)
        ])
    }
    
    private func configureViewModel() {
        viewModel.delegate = self
    }
}

// MARK: - Button Tapped
extension UserInfoViewController {
    
    @objc
    private func dismissViewController() {
        dismiss(animated: true)
    }
}

// MARK: - UIHelpers
extension UserInfoViewController {
    
    private func add(childVC: UIViewController,
                     to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
}

extension UserInfoViewController: UserInfoViewModelDelegate {
    
    func handleOutput(output: UserInfoViewModelOutput) {
        
        switch output {
        case .loadUserInfo(let user):
            configureUIElements(with: user)
        }
    }
}

// MARK: - Bind Data
extension UserInfoViewController {
    
    private func bindUserInfo() {
        Task { await viewModel.loadUserInfo() }
    }
}
