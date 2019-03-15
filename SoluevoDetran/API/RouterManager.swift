//
//  RouterManager.swift
//  SoluevoDetran
//
//  Created by Pedro Albuquerque on 12/03/19.
//  Copyright © 2019 Pedro Albuquerque. All rights reserved.
//

import Foundation
import Alamofire

typealias APIParams = [String : Any]?
typealias APIHeaders = [String : String]?

protocol RouterConfig: URLRequestConvertible {

    var url: URL { get }

    var params: APIParams { get }

    var headers: APIHeaders { get }

    var method: HTTPMethod { get }

    var endPoint: String { get }

    var urlWithParams: String { get }

    var task: task { get }
}

extension RouterConfig {

    var baseURL: String {
        return "http://159.65.244.68"
    }

    var apiVersion: String {
        return "v1"
    }

    var url: URL {
        return URL(string: "\(baseURL)/\(endPoint)/\(urlWithParams)")!
    }

    var headers: APIHeaders {
        return ["Authorization": "bearer \(APIManager.sharedInstance.accessToken)"]
    }

    var task: task {
        return .request
    }

    func asURLRequest() throws -> URLRequest {

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        let dataBody = ((params ?? Dictionary()).toJsonString ?? "").data(using: .utf8) ?? Data()
        urlRequest.httpBody = dataBody
        urlRequest.allHTTPHeaderFields = headers
        return urlRequest
    }

}

public enum task {
    case request
    case download
    case upload
}

enum RouterManager: URLRequestConvertible {
    
    case loginRouter(route: LoginRouter)
    case contractsRouter(route: ContractsRouter)

    func getroute() -> RouterConfig {
        switch self {
        case .loginRouter(let route):
            return route
        case .contractsRouter(let route):
            return route
        }
    }

    func tipotask() -> task {
        return getroute().task
    }

    func hasHeaders() -> Bool {
        return getHeaders() != nil
    }

    func getHeaders() -> APIHeaders {
        return getroute().headers
    }

    func getParams() -> APIParams {
        return getroute().params
    }

    func asURLRequest() throws -> URLRequest {
       return try getroute().asURLRequest()
    }

}
