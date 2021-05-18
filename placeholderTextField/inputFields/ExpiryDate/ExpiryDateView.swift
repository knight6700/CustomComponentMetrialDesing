//
//  ExpiryDateView.swift
//  placeholderTextField
//
//  Created by Mahmoud Fares on 18/05/2021.
//

import UIKit

class ExpiryDateView: UIView {

    @IBOutlet var containerView: UIView!
    @IBOutlet var monthlyTextField: UITextField!
    @IBOutlet var yearlyTextField: UITextField!
    var expiryDate: String?
    var isValid: Bool? {
        return validateCreditCardExpiry(expiryDate ?? "") == .valid
    }
    var expiryDateStatus: ExpiryValidation {
        return validateCreditCardExpiry(expiryDate ?? "")
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    private func commonInit() {
        setUPUI()
        monthlyTextField.delegate = self
        yearlyTextField.delegate = self
        yearlyTextField.isEnabled = false
    }

    private func setUPUI() {
        fromNib(type: Self.self)
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.gray.cgColor
        containerView.layer.cornerRadius = 5
        containerView.layer.masksToBounds = true
    }
    // remove it from internal class because in Project it's a extension UIView
    func fromNib<T: UIView>(type: T.Type) -> UIView? {
        let nibName = String(describing: type)
        guard let view = Bundle(for: type).loadNibNamed(nibName, owner: self, options: nil)?.first as? UIView else {
            return nil
        }
        self.addSubview(view)
        view.frame = self.bounds
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        return view
    }
    override func becomeFirstResponder() -> Bool {
        return monthlyTextField.becomeFirstResponder()
    }

}
