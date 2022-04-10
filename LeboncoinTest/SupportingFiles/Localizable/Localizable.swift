//
//  Localizable.swift
//  LeboncoinTest
//
//  Created by Janin Culhaoglu on 09/04/2022.
//

import Foundation

/// Localizable properyWrapper handle the logic of getting the localized string from a particular key.

@propertyWrapper
struct Localizable {
    var wrappedValue: String {
        didSet { wrappedValue = NSLocalizedString(wrappedValue, comment: "") }
    }

    init(wrappedValue: String) {
        self.wrappedValue = NSLocalizedString(wrappedValue, comment: "")
    }
}

/**
 The Strings enum stores all localized keys

 *With a single line of code we can access a localized string*
 ```
 label.text = Strings.homeTitle
 ```
 */

enum Strings {
    @Localizable static private(set) var adListTitle = "AdListTitle"
    @Localizable static private(set) var urgentAd = "UrgentAd"
    @Localizable static private(set) var filter = "Filter"
    @Localizable static private(set) var confirm = "Confirm"
}
