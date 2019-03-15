//
//  APIManager.swift
//  SoluevoDetran
//
//  Created by Pedro Albuquerque on 15/03/19.
//  Copyright © 2019 Pedro Albuquerque. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift

class APIManager {

    static let sharedInstance = APIManager()
    
    var accessToken = ""

    private var manager: Alamofire.SessionManager = {

        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        let manager = Alamofire.SessionManager(
            configuration: configuration
        )
        return manager
    }()

    func request(route: RouterManager, completion: @escaping (JSON) -> Void) {
        self.manager.request(route).responseJSON { response in

            guard let status = response.response?.statusCode else {
                completion(JSON.null)
                return
            }

            let jsonResp: JSON = ["statusCode": status, "resultValue": response.result.value ?? ""]

            guard response.result.value != nil else {
                completion(jsonResp)
                return
            }

            let json = JSON(response.result.value!)

            guard (response.result.value as? [String: AnyObject]) != nil else {
                completion(jsonResp)
                return
            }

            guard let jsonResult = try? jsonResp.merged(with: json) else {
                completion(json)
                return
            }

            completion(jsonResult)
        }
    }
    
    func setToken(user: UserModel) {
        
        guard let token = user.token else {return}
        self.accessToken = token
    }

    func cancelAllRequests() {
        manager.session.getAllTasks { tasks in
            tasks.forEach({
                $0.cancel()
            })
        }
    }

    private func verifyRequest(route: RouterManager, completion: @escaping (URLSessionTask?) -> Void ) {
        manager.session.getAllTasks { tasks in
            guard let urlroute = route.urlRequest?.url?.absoluteString,
                let requisicao = tasks.filter({
                    $0.originalRequest?.url?.absoluteString != nil && $0.originalRequest?.url?.absoluteString == urlroute
                }).first else {
                    completion(nil)
                    return
            }
            completion(requisicao)
        }
    }
    
    func cancelRequest(route: RouterManager) {
        verifyRequest(route: route) { task in
            guard task != nil else {
                return
            }
            self.cancel(task: task!)
        }
    }

    private func cancel(task: URLSessionTask) {
        task.cancel()
    }
}
