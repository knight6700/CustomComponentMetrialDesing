//
//  ViewController.swift
//  placeholderTextField
//
//  Created by Mahmoud Fares on 10/05/2021.
//

import UIKit
import MaterialComponents.MaterialTextControls_FilledTextAreas
import MaterialComponents.MaterialTextControls_FilledTextFields
import MaterialComponents.MaterialTextControls_OutlinedTextAreas
import MaterialComponents.MaterialTextControls_OutlinedTextFields
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let estimatedFrame = CGRect(x: 10, y: 200, width: view.frame.width - 20, height: 100)
        let textField = MDCOutlinedTextField(frame: estimatedFrame)
        textField.label.text = "Phone number"
        textField.placeholder = "555-555-5555"
        textField.leadingAssistiveLabel.text = "This is helper text"
        textField.sizeToFit()
        textField.leadingAssistiveLabel.lineBreakMode = .byWordWrapping
        
        view.addSubview(textField)
        
    }
    


}

