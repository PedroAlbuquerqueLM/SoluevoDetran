//
//  Vehicle.swift
//  SoluevoDetran
//
//  Created by Pedro Albuquerque on 18/03/19.
//  Copyright © 2019 Pedro Albuquerque. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class Vehicle: FormConfig {
    
    var dicForm: DicFormSection = [
        "veiculo" :
            (title: "Veículo",
             obj :
                ["remarcado": (title: "Remarcado", obj: ""),
                 "chassi" : (title: "Chassi", obj: ""),
                 "uf_placa" : (title: "Placa", obj: ""),
                 "renavam": (title: "Renavam", obj: "")
                ]
        )] as DicFormSection
    
    init(){}
    
    func getJSON() -> [String : String]? {
        var dic = [String: Any]()
        guard let dicVehicle = self.dicForm["veiculo"]?.obj else {return nil}
        dicVehicle.forEach {
            dic[$0.key] = $0.value.obj
        }
        
        return ["veiculo": dic.toJsonString ?? ""]
    }
}

