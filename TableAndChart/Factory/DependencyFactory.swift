//
//  DependencyFactory.swift
//  TableAndChart
//
//  Created by Mikhail on 08.10.2022.
//

import Foundation

protocol Factory {
    func makeStartViewController(coordinator: ProjectCoordinator) -> StartViewController
    func makeTableChartViewController(coordinator: ProjectCoordinator,
                                      data: [CoordinatesModel]) -> TableChartViewController
}

class DependencyFactory: Factory {
    
    func makeStartViewController(coordinator: ProjectCoordinator) -> StartViewController {
        let viewController = StartViewController()
        let presenter = StartPresenter(coordinator: coordinator, view: viewController)
        viewController.set(presenter: presenter)
        return viewController
    }
    
    func makeTableChartViewController(coordinator: ProjectCoordinator,
                                      data: [CoordinatesModel]) -> TableChartViewController {
        let viewController = TableChartViewController()
        let presenter = TableChartPresenter(view: viewController, coordinates: data)
        viewController.set(presenter: presenter)
        return viewController
    }
    
    func makeInitialCoordinator() -> ProjectCoordinator {
        let coordinator = ProjectCoordinator(factory: self)
        return coordinator
    }
}
