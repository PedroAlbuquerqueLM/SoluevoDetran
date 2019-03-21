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
    }
    
    func loadSubViews(){
        self.formullary = form
        guard let contractForm = viewModel.contract else {return}
        self.loadFormViews(form: contractForm)
        
    }
    
    func bind() {
        viewModel.contractSaved = { [unowned self] in
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    @objc func save(){
        viewModel.saveContract(code: 777888179)
    }
    
    func loadFormViews(form: Form){
        form.sections?.forEach{ section in
            let newSection = Section(section.title)
            self.formullary?.append(newSection)
            section.rows?.forEach{ row in
                let textRow = self.getTextRow(section: section, row: row)
                newSection.append(textRow)
            }
        }
    }
    
    func getTextRow(section: FormSection, row: FormRow) -> TextRow {
            let textRow = TextRow(){ textRow in
                textRow.title = row.title
                textRow.placeholder = "-"
                if compareType(varType: row.type, typeValue: Int.self) {
                    textRow.cell.textField.keyboardType = .numberPad
                }else if compareType(varType: row.type, typeValue: Double.self) {
                    textRow.cell.textField.keyboardType = .decimalPad
                }else {
                    textRow.cell.textField.keyboardType = .default
                }
                }.cellUpdate { cell, textRow in
                    guard let valueRow = textRow.value else {return}
                    row.value = valueRow.cast(type: row.type)
            }
            return textRow
    }
}
