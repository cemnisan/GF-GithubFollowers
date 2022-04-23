//
//  UIViewController+Ex.swift
//  GithubFollowers
//
//  Created by Cem Nisan on 22.04.2022.
//

import UIKit
import GFComponents
import SafariServices

fileprivate var containerView: UIView!

extension UIViewController {
    
    func presentGFAlertOnMainThread(title: String,
                                    message: String,
                                    buttonTitle: String) {
        DispatchQueue.main.async {
            let alertViewController = GFAlertViewController(alertTitle: title,
                                                            alertMessage: message,
                                                            alertButtonTitle: buttonTitle)
            alertViewController.modalPresentationStyle  = .overFullScreen
            alertViewController.modalTransitionStyle    = .crossDissolve
            
            self.present(alertViewController, animated: true)
        }
    }
    
    func showLoadingIndicator() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha           = 0
        
        UIView.animate(withDuration: 0.25) { containerView.alpha = 0.8 }
        
        let activityIndicator         = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
   func dissmisLoadingIndicator() {
       DispatchQueue.main.async {
           containerView.removeFromSuperview()
           containerView = nil
       }
    }
    
    func showEmptyStateView(with message: String,
                            in view: UIView) {
        let emptyStateView   = GFEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
    
    func presentSafariViewController(with url: URL) {
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.preferredControlTintColor = .systemGreen
        present(safariViewController, animated: true)
    }
}
