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
        contractsTableView.register(HeaderCell.self, forCellReuseIdentifier: "HeaderCell")
        
        let exitItem = UIBarButtonItem(title: "Sair", style: .done, target: self, action: #selector(logout))
        exitItem.tintColor = .black
        self.navigationItem.rightBarButtonItem = exitItem
        
        let profileItem = UIBarButtonItem(image: #imageLiteral(resourceName: "profileIcon"), style: .plain, target: self, action: nil)
        profileItem.tintColor = .black
        
        let titleItem = UIBarButtonItem(title: UserDAO.getUser()?.name, style: .done, target: self, action: nil)
        titleItem.tintColor = .black
        
        self.navigationItem.leftBarButtonItems = [profileItem, titleItem]
        
        
    }
    
    @objc func logout(){
        SessionManager.logout()
    }
}

extension ListContractsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel.contracts?.count ?? 0 ) + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as? HeaderCell else {
                return ContractCell()
            }
            
            cell.set(title: "Contratos", type: .add)
            cell.delegate = self
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContractCell", for: indexPath) as? ContractCell else {
                return ContractCell()
            }
            
            cell.contract = viewModel.contracts?[indexPath.row - 1]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 74
        }
        return 130
    }
}

extension ListContractsViewController: HeaderViewDelegate {
    func clickButtonAction() {
        print("Open Add Contract")
    }
}