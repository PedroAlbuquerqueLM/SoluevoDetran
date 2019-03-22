
//  File.swift
//  SoluevoDetran
//
//  Created by Pedro Albuquerque on 22/03/19.
//  Copyright © 2019 Pedro Albuquerque. All rights reserved.
//

import SwiftMessageBar
import UIKit

class SLMessageBar {
    class func showMessageBar(isSuccess:Bool, message: String){
        let config = SwiftMessageBar.Config.Builder()
            .withErrorColor(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1))
            .withSuccessColor(.greenDetran)
            .withTitleFont(.boldSystemFont(ofSize: 17))
            .withMessageFont(.systemFont(ofSize: 15))
            .build()
        SwiftMessageBar.setSharedConfig(config)
        SwiftMessageBar.showMessage(withTitle: (isSuccess ? "Sucesso" : "Erro"), message: message, type: (isSuccess ? .success : .error))
    }
}
