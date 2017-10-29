//
//  ReservationsService.swift
//  HotelManagement
//
//  Created by Bisera Belkoska on 16.10.17.
//  Copyright © 2017 Bisera Belkoska. All rights reserved.
//
import Foundation
import Moya

// MARK: - Provider setup

private func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data // fallback to original data if it can't be serialized.
    }
}

let reservationsProvider = MoyaProvider<Reservatons>(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])

// MARK: - Provider support

public enum Reservatons {
    case getAllReservations
    case getReservations(NSDate, NSDate)
    case addReservation
}

extension Reservatons: TargetType {
    public var baseURL: URL { return URL(string: "http://52.24.45.47/api")! }
    public var path: String {
        switch self {
        case .getAllReservations:
            return "/reservations"
        case .getReservations(let dateFrom, let dateTo):
            return "/reservations"
        case .addReservation:
            return "/addReservation"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getAllReservations,
             .getReservations:
            return .get
        case .addReservation:
            return .post
        }
    }
    
    public var parameters: [String: Any]? {
        switch self {
        case .getReservations(let dateFrom, let dateTo):
            var params = [String: Any]()
            params["dateFrom"] = dateFrom
            params["dateTo"] = dateTo
            return params
        default:
            return nil
        }
    }
    
    public var task: Task {
        switch self {
        case .getAllReservations:
            return .requestParameters(parameters: ["dateFrom": "dateTo"], encoding: URLEncoding.default)
        default:
            return .requestPlain
        }
    }
    public var validate: Bool {
        switch self {
        case .getAllReservations:
            return true
        default:
            return false
        }
    }
    public var sampleData: Data {
        switch self {
        case .getAllReservations:
            return "Half measures are as bad as nothing at all.".data(using: String.Encoding.utf8)!
        case .getReservations(let name):
            return "{\"login\": \"\(name)\", \"id\": 100}".data(using: String.Encoding.utf8)!
        case .addReservation(let name):
            return "[{\"name\": \"\(name)\"}]".data(using: String.Encoding.utf8)!
        }
    }
    public var headers: [String: String]? {
        return nil
    }
}

public func url(_ route: TargetType) -> String {
    return route.baseURL.appendingPathComponent(route.path).absoluteString
}
