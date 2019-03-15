//
//  User.swift
//  SoluevoDetran
//
//  Created by Pedro Albuquerque on 13/03/19.
//  Copyright © 2019 Pedro Albuquerque. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class UserModel: Object {
    
    @objc dynamic var financialsCode = 0
    @objc dynamic var uuid: String?
    @objc dynamic var token: String?
    @objc dynamic var name: String?
    
    override static func primaryKey() -> String? {
        return "uuid"
    }
    
}

