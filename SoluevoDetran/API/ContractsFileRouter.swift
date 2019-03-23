//
//  ContractsFileRouter.swift
//  SoluevoDetran
//
//  Created by Pedro Albuquerque on 22/03/19.
//  Copyright © 2019 Pedro Albuquerque. All rights reserved.
//

import Foundation
import Alamofire

enum ContractsFileRouter: RouterConfig {
    
    case getContractsFile(contractCode: Int)
    case saveContractFile(params: APIParams)
    
    var endPoint: String {
        switch self {
        case .getContractsFile(let code):
            return "detran/public/contract_files?contract_code=\(code)"
        default:
            return "contracts/file"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getContractsFile: return .get
        case.saveContractFile: return .post
        }
    }
    
    var urlWithParams: String {
        return ""
    }
    
    var params: APIParams {
        switch self {
        case .saveContractFile(let params):
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

