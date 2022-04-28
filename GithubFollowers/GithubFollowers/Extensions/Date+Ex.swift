//
//  Date+Ex.swift
//  GithubFollowers
//
//  Created by Cem Nisan on 28.04.2022.
//

import Foundation

extension Date {
 
    func convertToMonthYearFormat() -> String {
        let dateFormatter        = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
}
