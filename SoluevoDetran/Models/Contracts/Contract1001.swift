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

class Contract1001: Form {
    var title: String = ""
    var sections: [FormSection]?
    
    let secContract = FormSection(key: "contratos", title: "Contratos")
    let secVehicle = FormSection(key: "veiculo", title: "Veículo")
    let secPersonal = FormSection(key: "personal", title: "Pessoal")
    let secCredor = FormSection(key: "credor", title: "Credor")
    
    init(){
        self.sections = [secPersonal, secVehicle, secCredor, secContract]
        self.initRows()
    }
    
    func initRows(){
        secContract.rows = {
            return [
                FormRow(key: "numero_gravame", title: "Número do gravame", type: Int.self),
                FormRow(key: "quantidade_meses", title: "Quantidade de Meses", type: Int.self),
                FormRow(key: "tipo_restricao", title: "Tipo Restrição", type: String.self),
                FormRow(key: "taxa_mora", title: "Taxa Mora", type: Double.self),
                FormRow(key: "valor_taxa_mora", title: "Valor Taxa Mora", type: Double.self),
                FormRow(key: "taxa_taxa_multa", title: "Valor Taxa Multa", type: Double.self),
                FormRow(key: "valor_taxa_de_contrato", title: "Taxa de Contrato", type: Double.self),
                FormRow(key: "valor_juros_ao_mes", title: "Valor Juros ao Mês", type: Double.self),
                FormRow(key: "valor_juros_ao_ano", title: "Valor Juros ao Ano", type: Double.self),
                FormRow(key: "indices", title: "Indices", type: String.self),
                FormRow(key: "indicacao_comissao", title: "Indicação Comissão", type: String.self),
                FormRow(key: "comissao", title: "Comissão", type: Double.self),
                ]
        }()
        
        secVehicle.rows = {
            return [
                FormRow(key: "remarcado", title: "Remarcado", type: String.self),
                FormRow(key: "chassi", title: "Chassi", type: String.self),
                FormRow(key: "uf_placa", title: "UF Placa", type: String.self),
                FormRow(key: "renavam", title: "Renavam", type: String.self),
                ]
        }()
        
        secPersonal.rows = {
            return [
                FormRow(key: "name", title: "Nome", type: String.self),
                FormRow(key: "rg", title: "RG", type: String.self)
                ]
        }()
        
        secCredor.rows = {
            return [
                FormRow(key: "nome_agente_financeiro_instituicao_financeira", title: "Nome do Agente", type: String.self),
                FormRow(key: "cnpj", title: "CNPJ", type: Int.self),
                FormRow(key: "cep", title: "CEP", type: Int.self),
                FormRow(key: "endereco", title: "Endereço", type: String.self),
                FormRow(key: "endereco_numero", title: "Número", type: Int.self),
                FormRow(key: "endereco_numero_complemento", title: "Complemento", type: String.self),
                FormRow(key: "bairro", title: "Bairro", type: String.self),
                FormRow(key: "uf", title: "UF", type: String.self),
                FormRow(key: "municipio", title: "Cidade", type: String.self),
                FormRow(key: "telefone", title: "Telefone", type: String.self),
            ]
        }()
    }
}
