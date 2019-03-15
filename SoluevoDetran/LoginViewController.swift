//
//  ViewController.swift
//  SoluevoDetran
//
//  Created by Pedro Albuquerque on 12/03/19.
//  Copyright © 2019 Pedro Albuquerque. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realizaLogin()
        
    }
    
    func realizaLogin() {
        let params = ["financials_code": 1001,
                          "username": "a",
                          "password": "a"] as [String : Any]
        let rotaLogin = RouterManager.loginRouter(route: .login(params: params))
        APIManager.sharedInstance.request(route: rotaLogin) { json in
            UserDAO.saveUser(json: json)
            APIManager.sharedInstance.setToken(user: UserDAO.getUser()!)
        }
        
    }
}
