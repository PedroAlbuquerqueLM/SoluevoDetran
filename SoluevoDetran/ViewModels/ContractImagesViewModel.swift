//
//  ContractImagesViewModel.swift
//  SoluevoDetran
//
//  Created by Pedro Albuquerque on 23/03/19.
//  Copyright © 2019 Pedro Albuquerque. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage

protocol ContractImagesModelState: class {
    
    var imagesURLLoaded: (() -> Void)? { get }
    var startLoadingAnimating: (() -> Void)? { get }
    var endLoadingAnimating: (() -> Void)? { get }
}

class ContractImagesViewModel: ContractImagesModelState {
    var startLoadingAnimating: (() -> Void)?
    var endLoadingAnimating: (() -> Void)?
    
    var imagesURLLoaded: (() -> Void)?
    var contract: ContractModel?
    var images = [URL]()
    
    func getImages(){
        self.startLoadingAnimating?()
        guard let code = self.contract?.code else {return}
        self.images.removeAll()
        let route = RouterManager.contractsFileRouter(route: .getContractsFile(contractCode: code))
        APIManager.sharedInstance.request(route: route) { json in
            let resultValue = json["resultValue"].arrayValue
            resultValue.forEach{
                let fileName = $0["filename"].stringValue
                if let url = URL(string: "http://159.65.244.68/assets/\(fileName)") {
                    self.images.append(url)
                }
            }
            self.imagesURLLoaded?()
            self.endLoadingAnimating?()
        }
    }
    
    func uploadImage(_ image: UIImage){
        self.startLoadingAnimating?()
        guard let code = contract?.code else {return}
        let imageData = image.pngData() ?? Data()
        let params: APIParams = ["fileext": "png",
                                 "contract_code": code,
                                 "filename": "teste.png",
                                 "filecontent": imageData.base64EncodedString()
        ]
        
        let route = RouterManager.contractsFileRouter(route: .saveContractFile(params: params))
        APIManager.sharedInstance.request(route: route) { json in
            self.getImages()
        }
    }
}

