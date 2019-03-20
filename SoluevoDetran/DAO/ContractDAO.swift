//
//  ContractDAO.swift
//  SoluevoDetran
//
//  Created by Pedro Albuquerque on 17/03/19.
//  Copyright © 2019 Pedro Albuquerque. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

// swiftlint:disable force_try
class ContractDAO {

    static func save(contracts: [JSON]) {
        let realm = RealmManager.getRealm()
        try! realm.write {
            for (contract) in contracts {
                let newObj = ContractModel()
                newObj.code = contract["code"].intValue
                newObj.financialsCode = contract["financials_code"].intValue
                newObj.financialUsersUuid = contract["financial_users_uuid"].stringValue
                newObj.status = contract["status"].boolValue
                newObj.statusDetran = contract["status_detran"].boolValue
                newObj.lastUpdated = contract["last_update"].stringValue.brazillianISODate
                realm.add(newObj, update: true)
            }
        }
    }
    
    static func getContracts() -> [ContractModel] {
        return Array(RealmManager.getRealm().objects(ContractModel.self)).sorted(by: { $0.lastUpdated! > $1.lastUpdated! })
    }
    
    static func getContractsByUser() -> [ContractModel] {
        return ContractDAO.getContracts().filter{$0.financialUsersUuid == UserDAO.getUser()?.uuid}
    }
    
    static func deleteAll() {
        let realm = RealmManager.getRealm()
        try! realm.write {
            let contracts = RealmManager.getRealm().objects(ContractModel.self)
            realm.delete(contracts)
        }
    }
}

