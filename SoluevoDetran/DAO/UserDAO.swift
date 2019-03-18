//
//  UserDAO.swift
//  SoluevoDetran
//
//  Created by Pedro Albuquerque on 15/03/19.
//  Copyright © 2019 Pedro Albuquerque. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

// swiftlint:disable force_try
class UserDAO {
    
    static func saveUser(json: JSON) {
        self.deleteUser()
        let realm = RealmManager.getRealm()
        try! realm.write {
            let userDic = json["FinancialUser"].dictionaryValue
            let user = realm.object(ofType: UserModel.self,
                                    forPrimaryKey: UserModel.primaryKey())
                                                    ??
                                    UserModel(value: [UserModel.primaryKey(): userDic[UserModel.primaryKey()?.uppercased() ?? ""]?.stringValue]
                                )
            
            user.token = json["Token"].stringValue
            user.name = userDic["Name"]?.stringValue
            user.financialsCode = userDic["financials_code"]?.intValue ?? 0
            realm.add(user, update: true)
        }
    }

    static func getUser() -> UserModel? {
        return RealmManager.getRealm().objects(UserModel.self).first
    }
    
    static func deleteUser() {
        guard let user = getUser() else {return}
        let realm = RealmManager.getRealm()
        try! realm.write {
            let token = realm.object(ofType: UserModel.self, forPrimaryKey: user.uuid)
            realm.delete(token!)
        }
    }
}
