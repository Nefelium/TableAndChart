//
//  TableChartPresenter.swift
//  TableAndChart
//
//  Created by Mikhail on 08.10.2022.
//

import Foundation

protocol TableChartPresenterProtocol { }

class TableChartPresenter: TableChartPresenterProtocol  {
    weak var view: TableChartViewController?
    var coordinates: [CoordinatesModel]

    init(view: TableChartViewController, coordinates: [CoordinatesModel]) {
        self.view = view
        self.coordinates = coordinates
    }
}
