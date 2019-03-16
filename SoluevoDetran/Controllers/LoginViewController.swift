//
//  ViewController.swift
//  SoluevoDetran
//
//  Created by Pedro Albuquerque on 12/03/19.
//  Copyright © 2019 Pedro Albuquerque. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {
    
    fileprivate lazy var detranLogo: UIImageView = {
        let obj = UIImageView(frame: CGRect.zero)
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.contentMode = .scaleAspectFill
        obj.image = LoginViewModel.sharedInstance.states.first?.image
        return obj
    }()
    
    fileprivate lazy var titleWelcome: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .avenirBlack(30)
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.text = "Bem-vindo ao\nDetran"
        return label
    }()
    
    fileprivate lazy var plate: UIImageView = {
        let obj = UIImageView(frame: CGRect.zero)
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.contentMode = .scaleAspectFill
        obj.image = #imageLiteral(resourceName: "backgroundPlate")
        return obj
    }()
    
    fileprivate lazy var titleLogin: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .avenirBlack(30)
        label.textColor = .greenDetran
        label.text = "Login"
        return label
    }()
    
    fileprivate lazy var userText: SLTextFieldView = {
        let text = SLTextFieldView(title: "Usuário",
                                    fieldPlaceHolder: "Insira o usuário."
                                )
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    fileprivate lazy var passText: SLTextFieldView = {
        let text = SLTextFieldView(title: "Senha",
                                   fieldPlaceHolder: "Insira sua senha."
        )
        text.translatesAutoresizingMaskIntoConstraints = false
        text.field.isSecureTextEntry = true
        return text
    }()
    
    fileprivate lazy var stateText: SLTextFieldView = {
        let text = SLTextFieldView(title: "Estado",
                                   fieldPlaceHolder: "Selecione o estado."
        )
        text.translatesAutoresizingMaskIntoConstraints = false
        let states = LoginViewModel.sharedInstance.states.compactMap{$0.name}
        text.setPicker(pickerData: states)
        text.delegate = self
        return text
    }()
    
    fileprivate lazy var loginButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(#imageLiteral(resourceName: "loginButton"), for: .normal)
        button.addTarget(self, action: #selector(signInAction), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.bind()
        self.loadSubviews()
    }
    
    @objc func signInAction(){
        let viewModel = LoginViewModel.sharedInstance
        viewModel.signIn(code: viewModel.stateSelected?.contractID ?? 0, userName: self.userText.field.text, password: self.passText.field.text)
    }
    
    func bind() {
        let viewModel = LoginViewModel.sharedInstance
        viewModel.selectState = { [unowned self] state in
            self.detranLogo.image = state.image
        }
        viewModel.signIn = { [unowned self] in
            self.appDelegate.loggedVerify()
        }
    }
    
    func loadSubviews(){
        self.view.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
        
        self.view.addSubview(detranLogo)
        detranLogo.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60).isActive = true
        detranLogo.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 32).isActive = true
        detranLogo.heightAnchor.constraint(equalToConstant: 90).isActive = true
        detranLogo.widthAnchor.constraint(equalToConstant: 90).isActive = true
        
        self.view.addSubview(titleWelcome)
        titleWelcome.leftAnchor.constraint(equalTo: self.detranLogo.rightAnchor, constant: 32).isActive = true
        titleWelcome.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 28).isActive = true
        titleWelcome.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60).isActive = true
        titleWelcome.heightAnchor.constraint(equalToConstant: 90).isActive = true
        
        self.view.addSubview(plate)
        plate.topAnchor.constraint(equalTo: self.detranLogo.bottomAnchor, constant: 28).isActive = true
        plate.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 14).isActive = true
        plate.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -14).isActive = true
        plate.heightAnchor.constraint(equalToConstant: (ScreenSize.width - 28) * 1.1).isActive = true
        
        self.view.addSubview(titleLogin)
        titleLogin.leftAnchor.constraint(equalTo: self.plate.leftAnchor, constant: 21).isActive = true
        titleLogin.rightAnchor.constraint(equalTo: self.plate.rightAnchor, constant: -21).isActive = true
        titleLogin.topAnchor.constraint(equalTo: self.plate.topAnchor, constant: 19).isActive = true
        titleLogin.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        self.view.addSubview(stateText)
        stateText.leftAnchor.constraint(equalTo: self.plate.leftAnchor, constant: 23).isActive = true
        stateText.rightAnchor.constraint(equalTo: self.plate.rightAnchor, constant: -23).isActive = true
        stateText.topAnchor.constraint(equalTo: self.titleLogin.bottomAnchor, constant: 12).isActive = true
        
        self.view.addSubview(userText)
        userText.leftAnchor.constraint(equalTo: self.plate.leftAnchor, constant: 23).isActive = true
        userText.rightAnchor.constraint(equalTo: self.plate.rightAnchor, constant: -23).isActive = true
        userText.topAnchor.constraint(equalTo: self.stateText.bottomAnchor, constant: 12).isActive = true
        
        self.view.addSubview(passText)
        passText.leftAnchor.constraint(equalTo: self.plate.leftAnchor, constant: 23).isActive = true
        passText.rightAnchor.constraint(equalTo: self.plate.rightAnchor, constant: -23).isActive = true
        passText.topAnchor.constraint(equalTo: self.userText.bottomAnchor, constant: 12).isActive = true
        
        self.view.addSubview(loginButton)
        loginButton.rightAnchor.constraint(equalTo: self.plate.rightAnchor, constant: -13).isActive = true
        loginButton.bottomAnchor.constraint(equalTo: self.plate.bottomAnchor, constant: -16).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 63).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 63).isActive = true
    }
}

extension LoginViewController: SLTextFieldViewDelegate {
    func selectPicker(selected: String) {
        LoginViewModel.sharedInstance.setStateSelectedByName(selected)
    }
}
