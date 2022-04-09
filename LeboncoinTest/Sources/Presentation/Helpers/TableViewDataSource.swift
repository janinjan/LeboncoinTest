//
//  TableViewDataSource.swift
//  LeboncoinTest
//
//  Created by Janin Culhaoglu on 09/04/2022.
//

import UIKit

class TableViewDataSource<Model, CellType>: NSObject, UITableViewDataSource where CellType: UITableViewCell {

    typealias CellConfigurator = (Model, CellType) -> Void

    // MARK: - Properties

    var models: [Model]
    let reuseIdentifier: String
    private let cellConfigurator: CellConfigurator

    // MARK: - Initializer

    init(models: [Model], reuseIdentifier: String, cellConfigurator: @escaping CellConfigurator) {
        self.models = models
        self.reuseIdentifier = reuseIdentifier
        self.cellConfigurator = cellConfigurator
    }

    // MARK: - Methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? CellType else {
            return UITableViewCell()
        }

        let model = models[indexPath.row]
        cellConfigurator(model, cell)

        return cell
    }
}
