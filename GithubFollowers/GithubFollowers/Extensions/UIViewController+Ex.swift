//
//  UIViewController+Ex.swift
//  GithubFollowers
//
//  Created by Cem Nisan on 22.04.2022.
//

import UIKit
import GFComponents

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
}
