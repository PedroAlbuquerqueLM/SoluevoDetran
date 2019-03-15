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
    
    case detran()
    
    var endPoint: String {
        return "detran/public/contracts?code=123456789"
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
    
    var headers: APIHeaders {
        return [
                "key": "Authorization",
                "value": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1MTk0OTU54NDMsImlzcyI6IjM1NTA3OTA3ODM4In0.6W8AOQrla4d-e3PS5eGiteFLsEBRY-5hU_jJ4Uxcg5Y"
        ]
    }
}

