//
//  ContractViewController.swift
//  SoluevoDetran
//
//  Created by Pedro Albuquerque on 23/03/19.
//  Copyright © 2019 Pedro Albuquerque. All rights reserved.
//

import UIKit
import ImagePicker
import AlamofireImage
import JGProgressHUD

class ContractViewController: UIViewController {
    
    let viewModel = ContractImagesViewModel()
    
    let hud = JGProgressHUD(style: .dark)
    
    lazy var headerView: HeaderView = {
        let header = HeaderView()
        header.translatesAutoresizingMaskIntoConstraints = false
        header.set(title: "Imagens", type: .add)
        return header
    }()
    
    lazy var collectionImages: UICollectionView = {
        let width = (ScreenSize.width - 50)/2
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        layout.itemSize = CGSize(width: width, height: width * 1.13)
        let collect = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collect.translatesAutoresizingMaskIntoConstraints = false
        collect.backgroundColor = .clear
        return collect
    }()
    
    override func viewDidLoad() {
        
        self.view.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationItem.title = "Contrato - \(self.viewModel.contract?.code ?? 0)"
        self.bind()
        self.viewModel.getImages()
        self.loadSubViews()
    }
    
    func loadSubViews(){
        
        hud.textLabel.text = "Carregando"
        self.view.addSubview(headerView)
        headerView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        headerView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 74).isActive = true
        headerView.delegate = self
        
        self.view.addSubview(collectionImages)
        
        collectionImages.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        collectionImages.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        collectionImages.topAnchor.constraint(equalTo: self.headerView.bottomAnchor, constant: 10).isActive = true
        collectionImages.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        self.collectionImages.register(ContractImageCell.self, forCellWithReuseIdentifier: "ContractImageCell")
        
        collectionImages.delegate = self
        collectionImages.dataSource = self
    }
    
    func bind() {
        viewModel.imagesURLLoaded = { [unowned self] in
            self.collectionImages.reloadData()
        }
        viewModel.startLoadingAnimating = { [unowned self] in
            self.hud.show(in: self.view)
        }
        viewModel.endLoadingAnimating = { [unowned self] in
            self.hud.dismiss()
        }
    }
    
    func openGallery(){
        Configuration.doneButtonTitle = "Salvar"
        Configuration.noImagesTitle = "Desculpe! Nenhuma imagem disponível!"
        let imagePickerController = ImagePickerController()
        imagePickerController.imageLimit = 1
        imagePickerController.delegate = self
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
}

extension ContractViewController: HeaderViewDelegate {
    func clickButtonAction() {
        self.openGallery()
    }
}

extension ContractViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContractImageCell", for: indexPath) as? ContractImageCell else {
            return ContractImageCell()
        }
        let urlImage = self.viewModel.images[indexPath.row]
        cell.contractImage.af_setImage(withURL: urlImage)
        return cell
    }
    
    
}

extension ContractViewController: ImagePickerDelegate, UIImagePickerControllerDelegate,UIPopoverControllerDelegate,UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        self.viewModel.uploadImage(chosenImage)
        self.collectionImages.reloadData()
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        imagePicker.dismiss(animated: false, completion: nil)
        let picker:UIImagePickerController? = UIImagePickerController()
        picker!.allowsEditing = false
        picker?.delegate = self
        picker!.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.present(picker!, animated: true, completion: nil)
    }
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        if let image = images.first {
            self.viewModel.uploadImage(image)
            self.collectionImages.reloadData()
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
}
