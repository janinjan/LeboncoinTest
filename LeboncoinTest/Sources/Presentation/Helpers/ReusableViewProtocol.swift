//
//  ReusableViewProtocol.swift
//  LeboncoinTest
//
//  Created by Janin Culhaoglu on 09/04/2022.
//

import Foundation

protocol ReusableViewProtocol {
    static var reusableID: String { get }
}

// MARK: - extension ReusableViewProtocol

extension ReusableViewProtocol {
    static var reusableID: String {
        String(describing: self)
    }
}
