//
//  StartPresenter.swift
//  TableAndChart
//
//  Created by Mikhail on 08.10.2022.
//

import Foundation

protocol StartPresenterProtocol {
    func buttonPressed(count: Int)
}

class StartPresenter: StartPresenterProtocol {
    weak private var view: StartViewController?
    private var coordinator: ProjectCoordinator?
    let networkManager = NetworkManager()
    
    let mock = [CoordinatesModel(x: 1.23, y: 2.44),
                CoordinatesModel(x: 2.25, y: 14.4),
                CoordinatesModel(x: 6.93, y: 5.44),
                CoordinatesModel(x: 15.2, y: 10.11),
                CoordinatesModel(x: 6.53, y: 8.44),
                CoordinatesModel(x: 7.25, y: 13.4),
                CoordinatesModel(x: 12.9, y: 5.44),
                CoordinatesModel(x: 10.2, y: 0.71),
                CoordinatesModel(x: 7.08, y: 13.55)]
    
    func buttonPressed(count: Int) {
        getPoints(count: count)
    }
    
    init(coordinator: ProjectCoordinator, view: StartViewController) {
        self.coordinator = coordinator
        self.view = view
    }
    
    private func showDetails(data: [CoordinatesModel]) {
        coordinator?.moveToDetails(withData: data)
    }
    
    private func showErrorAlert(message: String) {
        coordinator?.presentErrorAlert(message: message)
    }
    
    private func getPoints(count: Int) {
        networkManager.getPoints(count: count) { [weak self] result in
            switch result {
            case .success(let points):
                self?.showDetails(data: points.points)
            case .failure(let error):
                self?.showErrorAlert(message: error.localizedDescription)
            }
        }
    }
}
