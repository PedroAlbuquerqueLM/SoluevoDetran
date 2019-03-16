//
//  State.swift
//  SoluevoDetran
//
//  Created by Pedro Albuquerque on 16/03/19.
//  Copyright © 2019 Pedro Albuquerque. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class State {
    
    @objc dynamic var contractID = 0
    @objc dynamic var name: String?
    @objc dynamic var image: UIImage?
    
    init(name: String, contractID: Int, image: UIImage){
        self.contractID = contractID
        self.name = name
        self.image = image
    }
}


