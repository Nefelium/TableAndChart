//
//  CoordinatesModel.swift
//  TableAndChart
//
//  Created by Mikhail on 08.10.2022.
//

import Foundation

struct Points: Codable {
    let points: [CoordinatesModel]
}

struct CoordinatesModel: Codable {
    let x: Double
    let y: Double
}
