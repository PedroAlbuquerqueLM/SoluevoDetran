//
//  HeaderView.swift
//  SoluevoDetran
//
//  Created by Pedro Albuquerque on 18/03/19.
//  Copyright © 2019 Pedro Albuquerque. All rights reserved.
//

import UIKit

enum HeaderViewType: String {
    case add = "btnAdd", none = ""
}

protocol HeaderViewDelegate: class {
    func clickButtonAction()
}

class HeaderView : UIView {
    
    weak var delegate: HeaderViewDelegate?
    
    lazy var title: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .avenirBlack(32)
        label.textColor = .black
        return label
    }()
    
    fileprivate lazy var button: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(clickButtonAction), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    init(){
        super.init(frame: CGRect.zero)
        self.clipsToBounds = true
        self.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
        self.loadSubViews()
    }
    
    func set(title: String, type: HeaderViewType) {
        self.title.text = title
        self.button.setBackgroundImage(UIImage(named: type.rawValue), for: .normal)
    }
    
    @objc func clickButtonAction(){
        self.delegate?.clickButtonAction()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadSubViews(){
        self.addSubview(button)
        button.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        button.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12).isActive = true
        button.heightAnchor.constraint(equalToConstant: 37).isActive = true
        button.widthAnchor.constraint(equalToConstant: 37).isActive = true
        
        self.addSubview(title)
        title.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12).isActive = true
        title.rightAnchor.constraint(equalTo: self.button.leftAnchor, constant: -12).isActive = true
        title.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
}

class HeaderCell: UITableViewCell {
    
    lazy var headerView: HeaderView = {
        let header = HeaderView()
        header.translatesAutoresizingMaskIntoConstraints = false
        return header
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.clipsToBounds = true
        self.selectionStyle = .none
        self.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
        self.loadSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadSubViews(){
        self.addSubview(headerView)
        headerView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive =  true
        headerView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: self.topAnchor).isActive =  true
        headerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}


