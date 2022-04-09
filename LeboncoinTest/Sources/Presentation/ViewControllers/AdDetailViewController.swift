//
//  AdDetailViewController.swift
//  LeboncoinTest
//
//  Created by Janin Culhaoglu on 09/04/2022.
//

import UIKit

class AdDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel: AdDetailViewModel
    weak var coordinator: AdListCoordinator?
    
    // MARK: - Initializer
    
    init(viewModel: AdDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lbcWhite
        title = viewModel.adDetail.title
    }
}
