//
//  LoginViewModel.swift
//  SoluevoDetran
//
//  Created by Pedro Albuquerque on 16/03/19.
//  Copyright © 2019 Pedro Albuquerque. All rights reserved.
//

import Foundation

protocol LoginViewModelState: class {
    
    var selectState: ((State) -> Void)? { get }
    var signIn: (() -> Void)? { get }
}

class LoginViewModel: LoginViewModelState {
    var selectState: ((State) -> Void)?
    var signIn: (() -> Void)?
    
    let states = [State(name: "CE", contractID: 1001, image: #imageLiteral(resourceName: "detranCE")), State(name: "RJ", contractID: 1001, image: #imageLiteral(resourceName: "detranRJ"))]
    
    var stateSelected: State? {
        didSet{
            guard let stateSelected = stateSelected else {return}
            self.selectState?(stateSelected)
        }
    }
    
    static let sharedInstance = LoginViewModel()
    
    init() {
        self.stateSelected = states.first
    }
    
    func setStateSelectedByName(_ name: String) {
        self.stateSelected = self.states.filter{$0.name == name}.first
    }
    
    func signIn(code: Int, userName: String?, password: String?) {
        let params = ["financials_code": code,
                      "username": userName ?? "",
                      "password": password ?? ""] as [String : Any]
        let loginRoute = RouterManager.loginRouter(route: .signIn(params: params))
        APIManager.sharedInstance.request(route: loginRoute) { json in
            
            if json["statusCode"].intValue == 200 {
                UserDAO.saveUser(json: json)
                APIManager.sharedInstance.setToken(user: UserDAO.getUser()!)
                self.signIn?()
                SLMessageBar.showMessageBar(isSuccess: true, message: "Seja bem-vindo \(UserDAO.getUser()?.name ?? "")")
            }else{
                print("ERRO NO LOGIN")
            }
        }
    }
}
