//
//  String+Extension.swift
//  LeboncoinTest
//
//  Created by Janin Culhaoglu on 09/04/2022.
//

import Foundation

extension String {

    var toDateFromISO8601: Date {
        return DateFormatter.iso8601DateFormatter.date(from: self) ?? Date()
    }
}
