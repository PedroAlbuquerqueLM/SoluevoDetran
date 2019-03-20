//
//  ContractManager.swift
//  SoluevoDetran
//
//  Created by Pedro Albuquerque on 18/03/19.
//  Copyright © 2019 Pedro Albuquerque. All rights reserved.
//

import Foundation

class ContractsManager {
    
    class func getContractObj() -> Form? {
        switch UserDAO.getUser()?.financialsCode {
        case 1001:
            return Contract1001()
        default:
            return nil
        }
    }
}

