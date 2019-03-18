//
//  SessionManager.swift
//  SoluevoDetran
//
//  Created by Pedro Albuquerque on 18/03/19.
//  Copyright © 2019 Pedro Albuquerque. All rights reserved.
//

import UIKit

class SessionManager {
    
    class func loggedVerify(){
        guard let user = UserDAO.getUser() else {
            let navigationController = UINavigationController(rootViewController: LoginViewController())
            navigationController.navigationBar.isHidden = true
            appDelegate.window?.rootViewController = navigationController
            appDelegate.window?.makeKeyAndVisible()
            return
        }
        let navigationController = UINavigationController(rootViewController: ListContractsViewController())
        APIManager.sharedInstance.accessToken = user.token ?? ""
        appDelegate.window?.rootViewController = navigationController
        appDelegate.window?.makeKeyAndVisible()
    }
    
    class func logout(){
        UserDAO.deleteUser()
        ContractDAO.deleteAll()
        SessionManager.loggedVerify()
    }
}
