//
//  Contract.swift
//  SoluevoDetran
//
//  Created by Pedro Albuquerque on 17/03/19.
//  Copyright © 2019 Pedro Albuquerque. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class ContractModel: Object {
    
    @objc dynamic var code = 0
    @objc dynamic var financialUsersUuid: String?
    @objc dynamic var statusDetran: Bool = false
    @objc dynamic var status: Bool = false
    @objc dynamic var lastUpdated: Date?
    @objc dynamic var financialsCode = 0
    
    override static func primaryKey() -> String? {
        return "code"
    }
    
}
