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
    
    var endPoint: String {
        return "detran/public/contracts"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var urlWithParams: String {
        return ""
    }
    
    var params: APIParams {
        return nil
    }
    
    var url: URL {
        let url = URL(string: "\(baseURL)/\(endPoint)")!
        return url
    }
    
}
