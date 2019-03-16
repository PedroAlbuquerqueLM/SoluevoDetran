//
//  SLTextFieldView.swift
//  SoluevoDetran
//
//  Created by Pedro Albuquerque on 16/03/19.
//  Copyright © 2019 Pedro Albuquerque. All rights reserved.
//

import UIKit
import McPicker

protocol SLTextFieldViewDelegate: class {
    func selectPicker(selected: String)
}

class SLTextFieldView: UIView {
    
    weak var delegate: SLTextFieldViewDelegate?
    
    lazy var title: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .avenirMedium(20)
        label.textColor = .black
        return label
    }()
    
    lazy var field: McTextField = {
        var text = McTextField(frame: .zero)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = .avenirMedium(14)
        text.textAlignment = .left
        text.borderStyle = .roundedRect
        text.textColor = #colorLiteral(red: 0.3921568627, green: 0.3921568627, blue: 0.3921568627, alpha: 1)
        return text
    }()
    
    lazy var arrow: UIImageView = {
        var arrow = UIImageView(frame: .zero)
        arrow.translatesAutoresizingMaskIntoConstraints = false
        arrow.image = #imageLiteral(resourceName: "arrow")
        arrow.contentMode = .scaleAspectFill
        arrow.isHidden = true
        return arrow
    }()
    
    init(title: String, fieldPlaceHolder: String) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 64))
        
        self.loadSubViews()
        self.title.text = title
        self.field.placeholder = fieldPlaceHolder
    }
    
    func setPicker(pickerData: [String]){
        let text = self.field
        let data: [[String]] = [pickerData]
        arrow.isHidden = false
        let mcInputView = McPicker(data: data)
        mcInputView.backgroundColor = .gray
        mcInputView.backgroundColorAlpha = 0.25
        text.inputViewMcPicker = mcInputView
        mcInputView.toolbarButtonsColor = .black
        text.text = pickerData[0]
        
        text.doneHandler = { [weak text] (selections) in
            text?.text = selections[0]!
            self.delegate?.selectPicker(selected: selections[0]!)
        }
        text.selectionChangedHandler = { [weak text] (selections, componentThatChanged) in
            text?.text = selections[componentThatChanged]!
            self.delegate?.selectPicker(selected: selections[componentThatChanged]!)
        }

        text.textFieldWillBeginEditingHandler = { [weak text] (selections) in
            if text?.text == "" {
                // Selections always default to the first value per component
                text?.text = selections[0]
                self.delegate?.selectPicker(selected: selections[0]!)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadSubViews(){
        self.heightAnchor.constraint(equalToConstant: 64).isActive = true
        
        self.addSubview(title)
        title.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        title.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        title.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        title.heightAnchor.constraint(equalToConstant: 27).isActive = true
        
        self.addSubview(field)
        field.topAnchor.constraint(equalTo: self.title.bottomAnchor, constant: 7).isActive = true
        field.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        field.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        field.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.field.addSubview(arrow)
        arrow.centerYAnchor.constraint(equalTo: self.field.centerYAnchor).isActive = true
        arrow.rightAnchor.constraint(equalTo: self.field.rightAnchor, constant: -11).isActive = true
        arrow.heightAnchor.constraint(equalToConstant: 7).isActive = true
        arrow.widthAnchor.constraint(equalToConstant: 15).isActive = true
    }
}
