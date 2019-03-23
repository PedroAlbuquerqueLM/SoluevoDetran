//
//  ContractsViewModel.swift
//  SoluevoDetran
//
//  Created by Pedro Albuquerque on 18/03/19.
//  Copyright © 2019 Pedro Albuquerque. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire

protocol ContractsViewModelState: class {
    
    var getContracts: (() -> Void)? { get }
    var startLoadingAnimating: (() -> Void)? { get }
    var endLoadingAnimating: (() -> Void)? { get }
}

class ContractsViewModel: ContractsViewModelState {
    
    var getContracts: (() -> Void)?
    var startLoadingAnimating: (() -> Void)?
    var endLoadingAnimating: (() -> Void)?
    
    var contracts: [ContractModel]?
    var contractSelected: ContractModel?
    
    func loadContracts() {
        self.startLoadingAnimating?()
        let route = RouterManager.contractsRouter(route: .getContracts())
        APIManager.sharedInstance.request(route: route) { json in
            if json["statusCode"].intValue == 200 {
                guard let resultsJSON = json.dictionaryValue["resultValue"]?.arrayValue else {return}
                ContractDAO.save(contracts: resultsJSON)
                self.contracts = ContractDAO.getContractsByUser()
                self.getContracts?()
            }else{
                print("ERRO")
            }
            self.endLoadingAnimating?()
        }
    }
}
