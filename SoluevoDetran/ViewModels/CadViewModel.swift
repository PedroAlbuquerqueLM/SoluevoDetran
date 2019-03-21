//
//  CadViewModel.swift
//  SoluevoDetran
//
//  Created by Pedro Albuquerque on 18/03/19.
//  Copyright © 2019 Pedro Albuquerque. All rights reserved.
//

import Foundation

protocol CadViewModelState: class {
    
    var contractSaved: (() -> Void)? { get }
}

class CadViewModel: CadViewModelState {
    
    var contractSaved: (() -> Void)?
    let contract = ContractsManager.getContractObj()
    
    func saveContract(code: Int){
        guard let contractJson = contract?.getJSONStr() else {return}
        let params = ["data": contractJson,
                      "code": code,
                      "financial_users_uuid": UserDAO.getUser()?.uuid ?? "",
                      "endusers_document": "35507907838"
            ] as [String : Any]
        let route = RouterManager.contractsRouter(route: .saveContract(params: params))
        APIManager.sharedInstance.request(route: route) { json in
            self.contractSaved?()
        }
    }
}
