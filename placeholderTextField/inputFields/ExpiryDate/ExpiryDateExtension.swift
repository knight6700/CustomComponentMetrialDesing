//
//  ExpiryDateExtension.swift
//  placeholderTextField
//
//  Created by Mahmoud Fares on 18/05/2021.
//

import UIKit
extension ExpiryDateView: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == monthlyTextField {
            if textField.text?.count == 2 , string.count != 0 {
                yearlyTextField.isEnabled = true
                yearlyTextField.becomeFirstResponder()
                yearlyTextField.text = string
                return false
            }else {
                return true
            }
        }else {
            var text = string
            if textField.text?.count == 2 && string.count != 0 {
                return false
            }else if textField.text!.count < 2 && string.count == 0{
                textField.text = ""
                monthlyTextField.becomeFirstResponder()
                return false
            }else if string.count == 0 {
                text = string
            } else {
                text += string
                return true
            }
        }
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if monthlyTextField.text?.count == 2 && yearlyTextField.text?.count == 2 {
            let year = yearlyTextField.text ?? ""
            let month = monthlyTextField.text ?? ""
            expiryDate = month  + year
            
        }
    }

}
