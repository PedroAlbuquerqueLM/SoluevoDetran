//
//  ContractsRouter.swift
//  SoluevoDetran
//
//  Created by Pedro Albuquerque on 13/03/19.
//  Copyright © 2019 Pedro Albuquerque. All rights reserved.
//

import Foundation
import Alamofire

enum ContractsRouter: RouterConfig {
    
    case getContracts()
    case saveContract(params: APIParams)
    
    var endPoint: String {
        return "detran/public/contracts"
    }
    
    var method: HTTPMethod {
        switch self {
        case .getContracts: return .get
        case.saveContract: return .post
        }
    }
    
    var urlWithParams: String {
        return ""
    }
    
    var params: APIParams {
        switch self {
        case .saveContract(let params):
            return params
        default:
            return nil
        }
    }
    
    var url: URL {
        let url = URL(string: "\(baseURL)/\(endPoint)")!
        return url
    }
    
}
