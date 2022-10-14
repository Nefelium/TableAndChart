//
//  PointsAPI.swift
//  TableAndChart
//
//  Created by Mikhail on 09.10.2022.
//

import Foundation
import Moya

enum PointsAPI {
    case getPoints(count: Int)
}

extension PointsAPI: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://hr-challenge.interactivestandard.com/api") else { fatalError() }
        return url
    }
    
    var path: String {
        switch self {
        case .getPoints:
            return "/test/points"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getPoints(let count):
            return .requestParameters(parameters: ["count": count], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
