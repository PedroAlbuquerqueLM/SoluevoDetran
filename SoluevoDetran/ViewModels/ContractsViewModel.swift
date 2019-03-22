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
}

class ContractsViewModel: ContractsViewModelState {
    
    var getContracts: (() -> Void)?
    var contracts: [ContractModel]?
    var contractSelected: ContractModel?
    
    func loadContracts() {
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
        }
    }
    
    func uploadImage(_ image: UIImage){
        guard let code = contractSelected?.code else {return}
        let imageData = image.pngData() ?? Data()
        let params: APIParams = ["fileext": "png",
                                 "contract_code": code,
                                 "filename": "teste.png",
                                 "filecontent": imageData.base64EncodedString()
        ]
        
        let route = RouterManager.contractsFileRouter(route: .saveContractFile(params: params))
        APIManager.sharedInstance.request(route: route) { json in
//            let filename = json["Filename"].stringValue
        }
    }
}
