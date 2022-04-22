//
//  GFAlertViewController.swift
//  
//
//  Created by Cem Nisan on 22.04.2022.
//

import UIKit

public final class GFAlertViewController: UIViewController {
    
    private let containerView   = GFAlertContainerView(frame: .zero)
    private let alertTitleLabel = GFTitleLabel(textAlignment: .center, fontSize: 20)
    private let alertBodyLabel  = GFBodyLabel(textAlignment: .center)
    private let alertButton     = GFButton(backgrounColor: .systemPink, title: "OK")
    
    private var alertTitle: String?
    private var alertMessage: String?
    private var alertButtonTitle: String?
    
    let padding: CGFloat        = 20
    
    public init(alertTitle: String,
                alertMessage: String,
                alertButtonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.alertTitle         = alertTitle
        self.alertMessage       = alertMessage
        self.alertButtonTitle   = alertButtonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
}

extension GFAlertViewController {
    
    private func configure() {
        configureViewController()
        configureContainerView()
        configureAlertTitle()
        configureAlertButtonTitle()
        configureAlertMessage()
    }
    
    private func configureViewController() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
    }
    
    private func configureContainerView() {
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
    
    private func configureAlertTitle() {
        containerView.addSubview(alertTitleLabel)
        alertTitleLabel.text = alertTitle
        
        NSLayoutConstraint.activate([
            alertTitleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            alertTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            alertTitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            alertTitleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    private func configureAlertMessage() {
        containerView.addSubview(alertBodyLabel)
        alertBodyLabel.text = alertMessage
        
        NSLayoutConstraint.activate([
            alertBodyLabel.topAnchor.constraint(equalTo: alertTitleLabel.bottomAnchor, constant: 8),
            alertBodyLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            alertBodyLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            alertBodyLabel.bottomAnchor.constraint(equalTo: alertButton.topAnchor, constant: -12)
        ])
    }
    
    private func configureAlertButtonTitle() {
        containerView.addSubview(alertButton)
        alertButton.setTitle(alertButtonTitle, for: .normal)
        alertButton.addTarget(self, action: #selector(dissmisViewController), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            alertButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            alertButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            alertButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            alertButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}

// MARK: - Action
extension GFAlertViewController {
    
    @objc
    private func dissmisViewController() {
        dismiss(animated: true)
    }
}
