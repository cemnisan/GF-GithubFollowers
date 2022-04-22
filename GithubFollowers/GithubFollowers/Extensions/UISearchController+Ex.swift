//
//  UISearchController+Ex.swift
//  GithubFollowers
//
//  Created by Cem Nisan on 22.04.2022.
//

import UIKit

extension UISearchController {
    var isSearching: Bool { return self.isActive && !self.searchBar.text!.isEmpty }
}
