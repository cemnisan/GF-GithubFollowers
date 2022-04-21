//
//  File.swift
//  
//
//  Created by Cem Nisan on 21.04.2022.
//

import Foundation

public enum Result<Value> {
    case success(Value)
    case failure(HTTPRequestError)
}
