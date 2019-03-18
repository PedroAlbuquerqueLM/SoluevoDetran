//
//  MainViewController.swift
//  SoluevoDetran
//
//  Created by Pedro Albuquerque on 16/03/19.
//  Copyright © 2019 Pedro Albuquerque. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let viewModel = ContractsViewModel()
    var contracts: [ContractModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.loadContracts()
    }
    
    func bind() {
        viewModel.getContracts = { [unowned self] in
            
        }
    }
}
