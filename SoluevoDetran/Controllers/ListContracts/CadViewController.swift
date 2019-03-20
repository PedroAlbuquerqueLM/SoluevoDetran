//
//  FormViewController.swift
//  SoluevoDetran
//
//  Created by Pedro Albuquerque on 18/03/19.
//  Copyright © 2019 Pedro Albuquerque. All rights reserved.
//

import UIKit
import Eureka

class CadViewController: FormViewController {
    
    var formullary: Eureka.Form?
    let viewModel = CadViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationItem.title = "Novo Contrato"
        let saveItem = UIBarButtonItem(title: "Salvar", style: .done, target: self, action: #selector(save))
        saveItem.tintColor = .black
        self.navigationItem.rightBarButtonItem = saveItem
        self.bind()
        self.loadSubViews()
//            <<< TextRow(){ row in
//                row.title = "Chassi"
//                row.placeholder = "-"
//                }.cellUpdate { cell, row in
//                    self.viewModel.vehicle.chassi = row.value
//            }
//            <<< TextRow(){ row in
//                row.title = "Renavam"
//                row.placeholder = "-"
//                }.cellUpdate { cell, row in
//                    self.viewModel.vehicle.renavam = row.value
//            }
//            <<< TextRow(){ row in
//                row.title = "Placa"
//                row.placeholder = "-"
//                }.cellUpdate { cell, row in
//                    self.viewModel.vehicle.placa = row.value
//            }
//            <<< TextRow(){ row in
//                row.title = "Remarcado"
//                row.placeholder = "-"
//                }.cellUpdate { cell, row in
//                    self.viewModel.vehicle.remarcado = row.value
//            }
//            <<< TextRow(){ row in
//                row.title = "Nome"
//                row.placeholder = "-"
//            }
//            <<< TextRow(){ row in
//                row.title = "RG"
//                row.placeholder = "-"
//            }
//            <<< TextRow(){ row in
//                row.title = "Taxa Mora"
//                row.placeholder = "-"
//            }
//            <<< TextRow(){ row in
//                row.title = "Valor IOF"
//                row.placeholder = "-"
//            }
//            <<< TextRow(){ row in
//                row.title = "Taxa Multa"
//                row.placeholder = "-"
//            }
//            <<< TextRow(){ row in
//                row.title = "Valor Multa"
//                row.placeholder = "-"
//            }
//            <<< TextRow(){ row in
//                row.title = "Quantidade de Meses"
//                row.placeholder = "-"
//            }
//            <<< TextRow(){ row in
//                row.title = "Número do Contrato"
//                row.placeholder = "-"
//            }
//            <<< TextRow(){ row in
//                row.title = "Valor Juros ao Ano"
//                row.placeholder = "-"
//            }
//            <<< TextRow(){ row in
//                row.title = "Valor Juros ao Mês"
//                row.placeholder = "-"
//            }
//            <<< DateRow(){
//                $0.title = "Data do Contrato"
//                $0.value = Date(timeIntervalSinceReferenceDate: 0)
//            }
//            
//            +++ Section("Credor")
//            <<< TextRow(){ row in
//                row.title = "Nome do Agente"
//                row.placeholder = "-"
//            }
//            <<< TextRow(){ row in
//                row.title = "CNPJ"
//                row.placeholder = "-"
//            }
//            <<< TextRow(){ row in
//                row.title = "Telefone"
//                row.placeholder = "-"
//            }
//            <<< TextRow(){ row in
//                row.title = "CEP"
//                row.placeholder = "-"
//            }
//            <<< TextRow(){ row in
//                row.title = "Bairro"
//                row.placeholder = "-"
//            }
//            <<< TextRow(){ row in
//                row.title = "Endereço"
//                row.placeholder = "-"
//            }
//            <<< TextRow(){ row in
//                row.title = "Número"
//                row.placeholder = "-"
//            }
//            <<< TextRow(){ row in
//                row.title = "Complemento"
//                row.placeholder = "-"
//            }
//            <<< TextRow(){ row in
//                row.title = "Municipio"
        //                row.placeholder = "-"
        //            }
        //            <<< TextRow(){ row in
        //                row.title = "Estado"
        //                row.placeholder = "-"
        //        }
    }
    
    func loadSubViews(){
        self.formullary = form
        guard let contractForm = viewModel.contract?.dicForm else {return}
        self.loadFormViews(form: contractForm, formConfig: viewModel.contract)
        self.loadFormViews(form: viewModel.credor.dicForm, formConfig: viewModel.credor)
        self.loadFormViews(form: viewModel.vehicle.dicForm, formConfig: viewModel.vehicle)
        
    }
    
    func bind() {
        viewModel.contractSaved = { [unowned self] in
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    @objc func save(){
        viewModel.saveContract(code: 777888179)
    }
    
    func loadFormViews(form: DicFormSection, formConfig: FormConfig?){
        form.forEach { vmDic in
            guard let formConfig = formConfig else {return}
            let newSection = Section(vmDic.value.title)
            self.formullary?.append(newSection)
            vmDic.value.obj.forEach { dic in
                let row = self.getRow(rowTitle: dic.value.title, sectionKey: vmDic.key, rowKey: dic.key, value: dic.value.obj, formConfig: formConfig)
                newSection.append(row)
            }
        }
    }
    
    func getRow(rowTitle: String, sectionKey: String, rowKey: String, value: Any, formConfig: FormConfig) -> TextRow {
            let textRow = TextRow(){ textRow in
                textRow.title = rowTitle
                textRow.placeholder = "-"
                if value is Int {
                    textRow.cell.textField.keyboardType = .numberPad
                }else if value is Double {
                    textRow.cell.textField.keyboardType = .decimalPad
                }else {
                    textRow.cell.textField.keyboardType = .default
                }
                }.cellUpdate { cell, textRow in
                    guard let valueRow = textRow.value else {return}
                    formConfig.setValue(section: sectionKey, row: rowKey, value: valueRow.cast(type: value))
            }
            return textRow
    }
}
