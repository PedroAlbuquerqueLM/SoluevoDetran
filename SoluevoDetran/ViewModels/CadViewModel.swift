//
//  CadViewModel.swift
//  SoluevoDetran
//
//  Created by Pedro Albuquerque on 18/03/19.
//  Copyright © 2019 Pedro Albuquerque. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage

protocol CadViewModelState: class {
    
    var contractSaved: (() -> Void)? { get }
}

class CadViewModel: CadViewModelState {
    var contractSaved: (() -> Void)?
    
    var code: String?
    let contract = ContractsManager.getContractObj()
    var images = [UIImage]()
    
    func saveContract(){
        guard let code = code else {
            SLMessageBar.showMessageBar(isSuccess: false, message: "Insira o número do contrato.")
            return
        }
        guard code.count <= 9 else {
            SLMessageBar.showMessageBar(isSuccess: false, message: "Número do contrato muito extenso.")
            return
        }
        guard let contractJson = contract?.getJSONStr() else {return}
        let params = ["data": contractJson,
                      "code": code.toInt,
                      "financial_users_uuid": UserDAO.getUser()?.uuid ?? "",
                      "endusers_document": "35507907838"
            ] as [String : Any]
        let route = RouterManager.contractsRouter(route: .saveContract(params: params))
        APIManager.sharedInstance.request(route: route) { json in
            self.contractSaved?()
            SLMessageBar.showMessageBar(isSuccess: true, message: "Contrato Salvo!")
        }
    }
}
