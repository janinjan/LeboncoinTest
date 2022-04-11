//
//  AdDetailViewModel.swift
//  LeboncoinTest
//
//  Created by Janin Culhaoglu on 09/04/2022.
//

import Foundation

final class AdDetailViewModel {

    // MARK: - Properties

    let adDetail: AdModel
    let descriptionText = Strings.description

    // MARK: - Initializer

    init(adDetail: AdModel) {
        self.adDetail = adDetail
    }
}
