//
//  Constants.swift
//  GithubFollowers
//
//  Created by Cem Nisan on 21.04.2022.
//

import UIKit

struct K {
    
    struct ReuseIDs {
        static let favoritesCellID              = "FavoritesTableViewCell"
        static let followersCellID              = "followersCell"
    }
            
    struct Image {
        static let logoImage                    = UIImage(named: "gh-logo")!
        static let locationImageView            = UIImage(systemName: "mappin.and.ellipse")!
    }
            
    struct Title {
        static let searchButtonTitle            = "Get Followers"
        static let favoritesNavTitle            = "Favorites"
    }
            
    struct Button {
        static let githubButtonTitle            = "Github Profile"
        static let getFollowerButtonTitle       = "Get Followers"
    }
            
    struct Search {
        static let followersPlaceHolder         = "Search for a username"
        static let searchPlaceholder            = "Enter a username"
    }
            
    struct Alert {
        struct URLError {
            static let title                    = "Something went wrong"
            static let message                  = "The url attachted to this user is invalid."
            static let buttonTitle              = "OK"
        }
                
        struct SuccessAddFavorites {
            static let title                    = "Success!"
            static let message                  = "You have successfully favorited this user 🎉"
            static let buttonTitle              = "OK"
        }
                
        struct FailureAddFavorites {
            static let title                    = "Failure!"
            static let message                  = "This user already exists in your favorites list!"
            static let buttonTitle              = "OK"
        }
                
        struct RequestError {
            static let title                    = "Something went wrong"
            static let buttonTitle              = "OK"
        }
                
        struct SearchError {
            static let title                    = "Something Went Wrong!"
            static let message                  = "Please give a username"
            static let buttonTitle              = "OK"
        }
    }
            
    struct EmptyView {
        static let message                      = "This doesn't have any followers. Go follow them."
    }
    
    struct Styling {
        static let maxPadding: CGFloat              = 50
        static let midPadding: CGFloat              = 20
        static let minPadding: CGFloat              = 8
        static let columnPadding: CGFloat           = 12
        static let columnSpacing: CGFloat           = 10
        static let followersImageSize: CGFloat      = 123
        static let favoritesImageSize: CGFloat      = 60
        static let logoImageTopAnchor: CGFloat      = 60
        static let logoImageSize: CGFloat           = 200
        static let tableViewRowHeight: CGFloat      = 80
        static let scrollViewHeight: CGFloat        = 600
        static let headerViewHeight: CGFloat        = 210
        static let userInfoViewHeight: CGFloat      = 140
        static let dateLabelHeight: CGFloat         = 50
        static let userInfoCornerRadius: CGFloat    = 18
        static let userInfoStackViewHeight: CGFloat = 50
        static let userInfoButtonHeight: CGFloat    = 44
    }
}
