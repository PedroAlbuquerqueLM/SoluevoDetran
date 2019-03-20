//
//  Credor.swift
//  SoluevoDetran
//
//  Created by Pedro Albuquerque on 18/03/19.
//  Copyright © 2019 Pedro Albuquerque. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class Credor: FormConfig {
    
    var dicForm: DicFormSection = [
        "personal" :
            (title: "Pessoal",
             obj:
                ["name" : (title: "Nome", obj: ""),
                 "rg" : (title: "RG", obj: "")
                ]
        ),
        "credor" :
            (title: "Credor",
             obj :
                ["nome_agente_financeiro_instituicao_financeira": (title: "Nome do Agente", obj: ""),
                 "cnpj" : (title: "CNPJ", obj: Int()),
                 "cep" : (title: "CEP", obj: Int()),
                 "endereco": (title: "Endereço", obj: ""),
                 "endereco_numero" : (title: "Número", obj: Int()),
                 "endereco_numero_complemento" : (title: "Complemento", obj: ""),
                 "bairro": (title: "Bairro", obj: ""),
                 "uf": (title: "Estado", obj: ""),
                 "municipio" : (title: "Cidade", obj: ""),
                 "telefone": (title: "Telefone", obj: "")
                ]
        )] as DicFormSection

    init(){}
    
    func getJSON() -> [String : String]? {
        var dicPersonal = [String: Any]()
        var dicCredor = [String: Any]()
        guard let dicFormPersonal = self.dicForm["personal"]?.obj else {return nil}
        guard let dicFormCredor = self.dicForm["credor"]?.obj else {return nil}
        dicFormPersonal.forEach {
            dicPersonal[$0.key] = $0.value.obj
        }
        dicFormCredor.forEach {
            dicCredor[$0.key] = $0.value.obj
        }
        
        return ["personal": dicPersonal.toJsonString ?? "", "credor": dicCredor.toJsonString ?? ""]
    }
}


