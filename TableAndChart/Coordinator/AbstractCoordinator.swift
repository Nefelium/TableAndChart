//
//  AbstractCoordinator.swift
//  TableAndChart
//
//  Created by Mikhail on 08.10.2022.
//

import Foundation

protocol AbstractCoordinator {
    func addChildCoordinator(_ coordinator: AbstractCoordinator)
    func removeAllChildCoordinatorsWith<T>(type: T.Type)
    func removeAllChildCoordinators()
}
