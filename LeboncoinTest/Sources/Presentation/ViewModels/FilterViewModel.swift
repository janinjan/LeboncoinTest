//
//  FilterViewModel.swift
//  LeboncoinTest
//
//  Created by Janin Culhaoglu on 10/04/2022.
//

import Foundation

final class FilterViewModel {
    
    // MARK: - Properties
    
    let title = Strings.filter
    let confirmButtonText = Strings.confirm
    var categories: [CategoryModel] = []
    
    // MARK: - Usecases
    
    private let categoryUsecase: CategoryUsecaseProtocol
    
    // MARK: - Initializer
    
    init(categoryUsecase: CategoryUsecaseProtocol) {
        self.categoryUsecase = categoryUsecase
    }
    
    // MARK: - Methods
    
    func getCategories() async {
        categories = await categoryUsecase.retrieveCategories().map({$0.toUI})
    }

    func didTapCategoryCell(at index: Int) -> CategoryModel {
        return categories[index]
    }
}
