//
//  AdListViewModel.swift
//  LeboncoinTest
//
//  Created by Janin Culhaoglu on 09/04/2022.
//

import Foundation

final class AdListViewModel {

    // MARK: - Properties

    let title = Strings.adListTitle
    var ads: [AdModel] = []

    // MARK: - Usecases

    private let adUsecase: AdUsecaseProtocol

    // MARK: - Initializer

    init(adUsecase: AdUsecaseProtocol) {
        self.adUsecase = adUsecase
    }
    
    // MARK: - Methods

    func getAds() async {
        ads = await adUsecase.retrieveAds().map({$0.toUI})
    }
}
