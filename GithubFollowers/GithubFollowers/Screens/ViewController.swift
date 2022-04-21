//
//  ViewController.swift
//  GithubFollowers
//
//  Created by Cem Nisan on 21.04.2022.
//

import UIKit
import GFNetwork

final class ViewController: UIViewController
{
    let service: FollowerServiceable = FollowerService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            let result = await service.getUserFollowers(with: "cemnisan")
            
            switch result {
            case .success(let followers):
                print(followers[1])
            case .failure(let error):
                print(error)
            }
        }
    }
}

