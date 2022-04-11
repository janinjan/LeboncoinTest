//
//  AdListViewModel.swift
//  LeboncoinTest
//
//  Created by Janin Culhaoglu on 09/04/2022.
//

import Foundation
import Combine

final class AdListViewModel {
    
    // MARK: - Properties
    
    var title = Strings.adListTitle
    let filterButtonText = Strings.filter
    let resetButtonText = Strings.reset
    var ads: [AdModel] = []
    var filteredAds: [AdModel] = []

    var numberOfTableViewItems: Int {
        return filteredAds.count
    }

    private var isAdsFiltered: Bool {
        return ads == filteredAds ? false: true
    }

    // MARK: - Publishers

    let resetPublisher = PassthroughSubject<Bool, Never>()
    
    // MARK: - Usecases
    
    private let adUsecase: AdUsecaseProtocol
    
    // MARK: - Initializer

    init(adUsecase: AdUsecaseProtocol) {
        self.adUsecase = adUsecase
    }
    
    // MARK: - Methods
    
    func getAds() async {
        ads = await adUsecase.retrieveAds().map({$0.toAdModel})
        filteredAds = ads
    }
    
    func getCellInfo(at index: Int) -> AdModel {
        return filteredAds[index]
    }

    func refresh(category: CategoryModel, updateData: @escaping (() -> Void)) {
        filteredAds = ads.filter({ $0.categoryName == category.name })
        title = category.name
        updateData()
        resetPublisher.send(isAdsFiltered)
    }

    func resetFilter() {
        filteredAds = ads
        title = Strings.adListTitle
        resetPublisher.send(isAdsFiltered)
    }
}
