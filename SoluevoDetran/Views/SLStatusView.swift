//
//  SLStatusView.swift
//  SoluevoDetran
//
//  Created by Pedro Albuquerque on 18/03/19.
//  Copyright © 2019 Pedro Albuquerque. All rights reserved.
//

import UIKit

enum SLStatusType: String {
    case detran = "do Detran", contract = "do Contrato"
}

class SLStatusView: UIView {
    
    var statusType: SLStatusType?
    var status: Bool? = false {
        didSet{
            if status ?? false {
                self.icon.image = #imageLiteral(resourceName: "trueIcon")
                self.title.text = "Status \(statusType?.rawValue ?? ""): Aprovado"
            }else{
                self.icon.image = #imageLiteral(resourceName: "falseIcon")
                self.title.text = "Status \(statusType?.rawValue ?? ""): Em Análise"
            }
        }
    }
    
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
        label.font = .avenirLight(12)
        label.textColor = .lightGrayDetran
        return label
    }()
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 16))
        
        self.loadSubViews()
    }
    
    func set(statusType: SLStatusType, status: Bool) {
        self.statusType = statusType
        self.status = status
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadSubViews(){
        self.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        self.addSubview(icon)
        icon.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        icon.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 15).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 15).isActive = true
        
        self.addSubview(title)
        title.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        title.leftAnchor.constraint(equalTo: self.icon.rightAnchor, constant: 12).isActive = true
        title.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        title.heightAnchor.constraint(equalToConstant: 16).isActive = true
    }
}

