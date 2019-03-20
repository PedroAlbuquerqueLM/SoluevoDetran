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
    let vehicle = Vehicle()
    let credor = Credor()
    
    func saveContract(code: Int){
        guard let contractJson = contract?.getJSON() else {return}
        guard let credorJson = credor.getJSON() else {return}
        guard let vehicleJson = vehicle.getJSON() else {return}
        let dic = credorJson.merged(with: contractJson)
        guard let dicString = dic.toJsonString?.removeRats else {return}
        let params = ["data": dicString ,
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
