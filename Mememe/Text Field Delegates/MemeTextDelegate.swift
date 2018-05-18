//
//  MemeTextDelegate.swift
//  Mememe
//
//  Created by tiago turibio on 18/04/18.
//  Copyright © 2018 tiago turibio. All rights reserved.
//

import Foundation
import UIKit

class MemeTextDelegate: NSObject, UITextFieldDelegate{
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.text = ""
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
