//
//  ContractImageCell.swift
//  SoluevoDetran
//
//  Created by Pedro Albuquerque on 23/03/19.
//  Copyright © 2019 Pedro Albuquerque. All rights reserved.
//

import UIKit
import JGProgressHUD

class ContractImageCell: UICollectionViewCell {
    
    lazy var contractImage: UIImageView = {
        let obj = UIImageView(frame: CGRect.zero)
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.contentMode = .scaleAspectFill
        obj.clipsToBounds = true
        obj.layer.cornerRadius = 7
        obj.layer.borderWidth = 1
        obj.backgroundColor = #colorLiteral(red: 0.6287905574, green: 0.6258816123, blue: 0.6465913653, alpha: 1)
        obj.layer.borderColor = #colorLiteral(red: 0.6287905574, green: 0.6258816123, blue: 0.6465913653, alpha: 1)
        return obj
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.clipsToBounds = true
        self.configuraSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configuraSubviews() {
        self.addSubview(contractImage)
        contractImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contractImage.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        contractImage.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        contractImage.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
}
