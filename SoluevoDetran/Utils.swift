//
//  Utils.swift
//  SoluevoDetran
//
//  Created by Pedro Albuquerque on 15/03/19.
//  Copyright © 2019 Pedro Albuquerque. All rights reserved.
//

import Foundation

extension Dictionary {
    var toJsonString: String? {
        let jsonData = try? JSONSerialization.data(withJSONObject: self, options: [])
        let jsonString = String(data: jsonData!, encoding: .utf8)
        return jsonString
    }
}
