//
//  UserInfoViewController.swift
//  GithubFollowers
//
//  Created by Cem Nisan on 22.04.2022.
//

import UIKit
import GFComponents

protocol UserInfoViewControllerDelegate: AnyObject {
    func didRequestUserFollwers(for username: String)
}

final class UserInfoViewController: UIViewController {
    
    private let scrollView        = UIScrollView()
    private let contentView       = UIView()
    
    private let headerView        = UIView()
    private let userFollowersView = UIView()
    private let userReposView     = UIView()
    private let dateLabel         = GFBodyLabel(textAlignment: .center)
    
    private var viewModel: UserInfoViewModelProtocol!
    
    private weak var delegate: UserInfoViewControllerDelegate?
    
    init(viewModel: UserInfoViewModelProtocol, delegate: UserInfoViewControllerDelegate?) {
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel = viewModel
        self.delegate  = delegate
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
    
    private func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.pinToEdges(of: view)
        contentView.pinToEdges(of: scrollView)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: K.Styling.scrollViewHeight)
        ])
    }
    
    private func layoutUI() {
        [headerView,
         userReposView,
         userFollowersView,
         dateLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: K.Styling.midPadding),
                $0.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -K.Styling.midPadding)
            ])
        }
            
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: K.Styling.headerViewHeight),
            
            userReposView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: K.Styling.midPadding),
            userReposView.heightAnchor.constraint(equalToConstant: K.Styling.userInfoViewHeight),
            
            userFollowersView.topAnchor.constraint(equalTo: userReposView.bottomAnchor, constant: K.Styling.midPadding),
            userFollowersView.heightAnchor.constraint(equalToConstant: K.Styling.userInfoViewHeight),
            
            dateLabel.topAnchor.constraint(equalTo: userFollowersView.bottomAnchor, constant: K.Styling.midPadding),
            dateLabel.heightAnchor.constraint(equalToConstant: K.Styling.dateLabelHeight)
        ])
    }
    
    private func configureUIElements(with user: UserInfoPresentation) {
        let userJoinedDate             = viewModel.userJoinedDate.convertToMonthYearFormat()
        dateLabel.text                 = "Github since \(userJoinedDate)"
        
        let headerViewController       = UserInfoHeaderViewController(user: user)
        let repoItemViewController     = RepoItemInfoViewController(user: user, delegate: self)
        let followerItemViewController = FollowerItemInfoViewController(user: user, delegate: self)
        
        add(childVC: headerViewController,       to: self.headerView)
        add(childVC: repoItemViewController,     to: self.userReposView)
        add(childVC: followerItemViewController, to: self.userFollowersView)
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

// MARK: - UserInfoViewModel Output
extension UserInfoViewController: UserInfoViewModelDelegate {
    
    func handleOutput(output: UserInfoViewModelOutput) {
        switch output {
        case .loadUserInfo(let user):
            configureUIElements(with: user)
        }
    }
}

// MARK: - RepoItemInfo Delegate
extension UserInfoViewController: RepoItemInfoDelegate {
    
    func githubProfileButtonTapped(for user: UserInfoPresentation) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(title: K.Alert.URLError.title,
                                       message: K.Alert.URLError.message,
                                       buttonTitle: K.Alert.URLError.buttonTitle)
            return
        }
        presentSafariViewController(with: url)
    }
}

// MARK: - FollowerItemInfo Delegate
extension UserInfoViewController: FollowerItemInfoDelegate {
    
    func getFollowerButtonTapped(for user: UserInfoPresentation) {
        delegate?.didRequestUserFollwers(for: user.login)
        dismissViewController()
    }
}

// MARK: - Bind Data
extension UserInfoViewController {
    
    private func bindUserInfo() {
        Task { await viewModel.loadUserInfo() }
    }
}
