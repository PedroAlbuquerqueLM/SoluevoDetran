//
//  FormModelManager.swift
//  SoluevoDetran
//
//  Created by Pedro Albuquerque on 20/03/19.
//  Copyright © 2019 Pedro Albuquerque. All rights reserved.
//

protocol Form: class {
    var title: String {get set}
    var sections: [FormSection]? {get set}
    func getJSONStr() -> String?
}

extension Form {
    func getJSONStr() -> String? {
        var dicSec = [String: String]()
        self.sections?.forEach{ section in
            var dicRow = [String: Any]()
            section.rows?.forEach{ row in
                guard let value = row.value else {return}
                dicRow[row.key] = value
            }
            let dicStr = [section.key : (dicRow.toJsonString ?? "")]
            dicSec = dicSec.merged(with: dicStr)
        }
        
        return dicSec.toJsonString?.removeRats
    }
}

class FormSection {
    var key: String
    var title: String
    var rows: [FormRow]?
    
    init(key: String, title: String) {
        self.title = title
        self.key = key
    }
}

class FormRow {
    var key: String
    var title: String
    var type: Any
    var value: Any?
    
    init<T>(key: String, title: String, type: T) {
        self.key = key
        self.title = title
        self.type = T.self
    }
}
