//
//  LoginViewModel.swift
//  SoluevoDetran
//
//  Created by Pedro Albuquerque on 16/03/19.
//  Copyright © 2019 Pedro Albuquerque. All rights reserved.
//

import Foundation

protocol LoginViewModelDelegate: class {
}

class LoginViewModel {
    
    static let sharedInstance = LoginViewModel()
    
    func signIn(code: Int, userName: String?, password: String?, completion: @escaping (Bool) -> Void) {
        let params = ["financials_code": code,
                      "username": userName ?? "",
                      "password": password ?? ""] as [String : Any]
        let loginRoute = RouterManager.loginRouter(route: .signIn(params: params))
        APIManager.sharedInstance.request(route: loginRoute) { json in
            UserDAO.saveUser(json: json)
            APIManager.sharedInstance.setToken(user: UserDAO.getUser()!)
        }
    }
}
