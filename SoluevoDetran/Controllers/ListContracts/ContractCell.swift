//
//  ContractCell.swift
//  SoluevoDetran
//
//  Created by Pedro Albuquerque on 18/03/19.
//  Copyright © 2019 Pedro Albuquerque. All rights reserved.
//

import UIKit

class ContractCell: UITableViewCell {
    
    var contract: ContractModel? {
        didSet {
            guard let contract = contract else {return}
            self.contractStatus.set(statusType: .contract, status: contract.status)
            self.detranStatus.set(statusType: .detran, status: contract.statusDetran)
            self.title.text = "Contrato - \(contract.code)"
        }
    }
    
    fileprivate lazy var backgroundCard: UIImageView = {
        let obj = UIImageView(frame: CGRect.zero)
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.contentMode = .scaleAspectFill
        obj.image = #imageLiteral(resourceName: "backgroundCard")
        return obj
    }()
    
    fileprivate lazy var icon: UIImageView = {
        let obj = UIImageView(frame: CGRect.zero)
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.contentMode = .scaleAspectFill
        obj.image = #imageLiteral(resourceName: "contractIcon")
        return obj
    }()
    
    fileprivate lazy var title: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .avenirMedium(20)
        label.textColor = UIColor.grayDetran
        label.numberOfLines = 0
        return label
    }()
    
    fileprivate lazy var detranStatus: SLStatusView = {
        let status = SLStatusView()
        status.translatesAutoresizingMaskIntoConstraints = false
        return status
    }()
    
    fileprivate lazy var contractStatus: SLStatusView = {
        let status = SLStatusView()
        status.translatesAutoresizingMaskIntoConstraints = false
        return status
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.clipsToBounds = true
        self.selectionStyle = .none
        self.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
        self.configuraSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configuraSubviews() {
        self.addSubview(backgroundCard)
        backgroundCard.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        backgroundCard.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        backgroundCard.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12).isActive = true
        backgroundCard.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12).isActive = true
        
        self.backgroundCard.addSubview(icon)
        icon.leftAnchor.constraint(equalTo: self.backgroundCard.leftAnchor, constant: 15).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 74).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 74).isActive = true
        icon.centerYAnchor.constraint(equalTo: self.backgroundCard.centerYAnchor).isActive = true
        
        self.backgroundCard.addSubview(title)
        title.rightAnchor.constraint(equalTo: self.backgroundCard.rightAnchor, constant: 14).isActive = true
        title.leftAnchor.constraint(equalTo: self.icon.rightAnchor, constant: 14).isActive = true
        title.topAnchor.constraint(equalTo: self.backgroundCard.topAnchor, constant: 16).isActive = true
        title.heightAnchor.constraint(equalToConstant: 27).isActive = true
        
        self.backgroundCard.addSubview(detranStatus)
        detranStatus.rightAnchor.constraint(equalTo: self.backgroundCard.rightAnchor, constant: 14).isActive = true
        detranStatus.leftAnchor.constraint(equalTo: self.icon.rightAnchor, constant: 14).isActive = true
        detranStatus.topAnchor.constraint(equalTo: self.title.bottomAnchor, constant: 13).isActive = true
        
        self.backgroundCard.addSubview(contractStatus)
        contractStatus.rightAnchor.constraint(equalTo: self.backgroundCard.rightAnchor, constant: 14).isActive = true
        contractStatus.leftAnchor.constraint(equalTo: self.icon.rightAnchor, constant: 14).isActive = true
        contractStatus.topAnchor.constraint(equalTo: self.detranStatus.bottomAnchor, constant: 8).isActive = true
        
    }
    
}

