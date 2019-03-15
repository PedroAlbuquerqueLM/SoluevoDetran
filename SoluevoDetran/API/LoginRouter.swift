//
//  LoginRouter.swift
//  SoluevoDetran
//
//  Created by Pedro Albuquerque on 15/03/19.
//  Copyright © 2019 Pedro Albuquerque. All rights reserved.
//

import Foundation
import Alamofire

enum LoginRouter: RouterConfig {

    case login(params: APIParams)
    case logout()

    var endPoint: String {
        return "auth/financial"
    }

    var method: HTTPMethod {
        return .post
    }

    var urlWithParams: String {
        return ""
    }

    var params: APIParams {
        switch self {
        case .login(let params):
            return params
        default:
            return nil
        }
    }

    var url: URL {
        let url = URL(string: "\(baseURL)/\(endPoint)")!
        return url
    }

    var headers: APIHeaders { return nil }

}
