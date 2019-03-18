//
//  MainViewController.swift
//  SoluevoDetran
//
//  Created by Pedro Albuquerque on 16/03/19.
//  Copyright © 2019 Pedro Albuquerque. All rights reserved.
//

import UIKit

class ListContractsViewController: UIViewController {
    
    lazy var contractsTableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = UIColor.clear
        table.tableFooterView = UIView()
        table.separatorColor = UIColor.clear
        return table
    }()
    
    let viewModel = ContractsViewModel()
    var contracts: [ContractModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bind()
        self.configuraSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.loadContracts()
    }
    
    func bind() {
        viewModel.getContracts = { [unowned self] in
            self.contractsTableView.reloadData()
        }
    }
    
    func configuraSubviews() {
        self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.view.addSubview(contractsTableView)
        contractsTableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        contractsTableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        contractsTableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        contractsTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        // TBEmptyDataSet
        contractsTableView.dataSource = self
        contractsTableView.delegate = self
        contractsTableView.register(ContractCell.self, forCellReuseIdentifier: "ContractCell")
        
    }
}

extension ListContractsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.contracts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContractCell", for: indexPath) as? ContractCell else {
            return ContractCell()
        }
        
        cell.contract = viewModel.contracts?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    
    
}
