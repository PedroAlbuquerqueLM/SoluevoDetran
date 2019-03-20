//
//  Contract1001.swift
//  SoluevoDetran
//
//  Created by Pedro Albuquerque on 18/03/19.
//  Copyright © 2019 Pedro Albuquerque. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class Contract1001: FormConfig {
    var dicForm: DicFormSection = [
        "contrato" :
        (title: "Contrato",
         obj :
            ["numero_gravame": (title: "Número do gravame", obj: Int()),
             "quantidade_meses" : (title: "Quantidade de Meses", obj: Int()),
             "tipo_restricao" : (title: "Tipo Restrição", obj: ""),
             "taxa_mora": (title: "Taxa Mora", obj: Double()),
             "valor_taxa_mora" : (title: "Valor Taxa Mora", obj: Double()),
             "taxa_taxa_multa" : (title: "Taxa Mora Multa", obj: Double()),
             "valor_taxa_multa": (title: "Valor Taxa Mora Multa", obj: Double()),
             "valor_taxa_de_contrato": (title: "Taxa de Contrato", obj: Double()),
             "valor_juros_ao_mes" : (title: "Valor Juros ao Mês", obj: Double()),
             "valor_juros_ao_ano": (title: "Valor Juros ao Ano", obj: Double()),
             "indices" : (title: "Indices", obj: ""),
             "indicacao_comissao" : (title: "Indicação Comissão", obj: ""),
             "comissao" : (title: "Comissão", obj: Double())
            ]
        )] as DicFormSection
    
    init(){}
    
    func getJSON() -> [String : String]? {
        var dic = [String: Any]()
        guard let dicContract = self.dicForm["contrato"]?.obj else {return nil}
        dicContract.forEach {
            dic[$0.key] = $0.value.obj
        }
        
        return ["contrato": dic.toJsonString ?? ""]
    }
}
