//
//  Float+Extension.swift
//  LeboncoinTest
//
//  Created by Janin Culhaoglu on 10/04/2022.
//

import Foundation

extension Float {
    
    /**
     Remove a decimal from a float if the decimal is equal to 0
     */
    var cleanValue: String {
        return String(format: "%g", self)
    }
}
