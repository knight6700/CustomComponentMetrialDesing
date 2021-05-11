//
//  TextFieldHoshi.swift
//  placeholderTextField
//
//  Created by Mahmoud Fares on 10/05/2021.
//

import UIKit

private enum Constants {
    static let offset: CGFloat = 8
    static let placeholderSize: CGFloat = 16
    static let arrowPadding: CGFloat = 5
}

@IBDesignable open class HoshiTextField: TextFieldEffects {
    @IBInspectable dynamic open var borderInactiveColor: UIColor? {
        didSet {
            updateBorder()
        }
    }
    
    @IBInspectable dynamic open var borderActiveColor: UIColor? {
        didSet {
            updateBorder()
        }
    }
    
    @IBInspectable dynamic open var placeholderColor: UIColor = .black {
        didSet {
            updatePlaceholder()
        }
    }
    
    /**
     The scale of the placeholder font.
     
     This property determines the size of the placeholder label relative to the font size of the text field.
    */
    @IBInspectable dynamic open var placeholderFontScale: CGFloat = 0.65 {
        didSet {
            updatePlaceholder()
        }
    }

    override open var placeholder: String? {
        didSet {
            updatePlaceholder()
        }
    }
    
    override open var bounds: CGRect {
        didSet {
            updateBorder()
            updatePlaceholder()
        }
    }
    @IBInspectable var leftPadding: CGFloat = 0
    @IBInspectable var rightPadding: CGFloat = 20
    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }

    @IBInspectable var rightImage: UIImage? {
        didSet {
            updateView()
        }
    }
    @IBInspectable var color: UIColor = UIColor.white {
        didSet {
            updateView()
        }
    }


    func updateView() {
        if let image = leftImage {
            leftViewMode = UITextField.ViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            imageView.tintColor = color
            leftView = imageView
        } else {
            leftView = nil
            leftViewMode = UITextField.ViewMode.never
        }

        if let rightImage = rightImage {
            rightViewMode = UITextField.ViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.contentMode = .scaleAspectFit
            imageView.image = rightImage
            imageView.tintColor = color
            rightView = imageView
        } else {
            rightView = nil
            rightViewMode = UITextField.ViewMode.never
        }
    }
    open override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRec = super.leftViewRect(forBounds: bounds)
        textRec.origin.x += leftPadding
        return textRec
    }

    open override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRec = super.rightViewRect(forBounds: bounds)
        textRec.origin.x -= rightPadding
        return textRec
    }

        
    private let borderThickness: (active: CGFloat, inactive: CGFloat) = (active: 2, inactive: 0.5)
    private let placeholderInsets = CGPoint(x: 10, y: 20)
    private let textFieldInsets = CGPoint(x: 5, y: 0)
    private let borderLayer = CALayer()

    private var activePlaceholderPoint: CGPoint = CGPoint.zero
    private var isFirst = true
    public  var error: String?
    private var errorLabel =  UILabel()
    // MARK: - TextFieldEffects
    
    override open func drawViewsForRect(_ rect: CGRect) {
        let frame = CGRect(origin: CGPoint.zero, size: CGSize(width: rect.size.width, height: rect.size.height))

        placeholderLabel.frame = frame.insetBy(dx: placeholderInsets.x, dy: placeholderInsets.y)
        placeholderLabel.font = placeholderFontFromFont(font!)
        
        updateBorder()
        updatePlaceholder()
        layer.insertSublayer(borderLayer, at: 0)
        borderLayer.addSublayer(placeholderLabel.layer)
        layer.insertSublayer(placeholderLabel.layer, at: 1)
    }
    
    override open func animateViewsForTextEntry() {
        if text!.isEmpty {
            UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: .beginFromCurrentState, animations: ({
                self.placeholderLabel.frame.origin = CGPoint(x: 10, y: self.placeholderLabel.frame.origin.y)
                self.placeholderLabel.alpha = 0
            }), completion: { _ in
                self.animationCompletionHandler?(.textEntry)
            })
        }
    
        layoutPlaceholderInTextRect()
        placeholderLabel.frame.origin = activePlaceholderPoint

        UIView.animate(withDuration: 0.4, animations: {
            self.placeholderLabel.alpha = 1.0
        })

    }
    
    override open func animateViewsForTextDisplay() {
        if let text = text, text.isEmpty {
            UIView.animate(withDuration: 0.35, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 2.0, options: .beginFromCurrentState, animations: ({
                self.layoutPlaceholderInTextRect()
                self.placeholderLabel.alpha = 1
                self.placeholderLabel.frame.origin = CGPoint(x: 10, y: 20)
            }), completion: { _ in
                self.animationCompletionHandler?(.textDisplay)
            })
            

        }
    }
    
    // MARK: - Private
    
    private func updateBorder() {
        borderLayer.frame = rectForBorder(frame)
        borderLayer.borderWidth = 1
        borderLayer.borderColor = #colorLiteral(red: 0.6747753024, green: 0.6747914553, blue: 0.674782753, alpha: 1)
        borderLayer.cornerRadius = 5
        borderLayer.masksToBounds = true
    }
    private func rectForBorder(_ bounds: CGRect) -> CGRect {
        let newRect = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
        
        return newRect
    }

    
    private func updatePlaceholder() {
        placeholderLabel.text = placeholder
        placeholderLabel.textColor = placeholderColor
        placeholderLabel.sizeToFit()
//        layoutPlaceholderInTextRect()
        
        if isFirstResponder || text!.isNotEmpty {
            animateViewsForTextEntry()
        }
    }
    
    private func placeholderFontFromFont(_ font: UIFont) -> UIFont! {
        let smallerFont = UIFont(descriptor: font.fontDescriptor, size: font.pointSize * placeholderFontScale)
        return smallerFont
    }
        
    private func layoutPlaceholderInTextRect() {
        let textRect = self.textRect(forBounds: bounds)
        var originX = textRect.origin.x
        switch self.textAlignment {
        case .center:
            originX += textRect.size.width/2 - placeholderLabel.bounds.width/2
        case .right:
            originX += textRect.size.width - placeholderLabel.bounds.width
        default:
            break
        }
        placeholderLabel.frame = CGRect(x: originX + 10 , y: (textRect.height/2) - 2,
                                        width: isFirst ? placeholderLabel.bounds.width + 5: placeholderLabel.bounds.width, height: placeholderLabel.bounds.height)
        activePlaceholderPoint = CGPoint(x: placeholderLabel.frame.origin.x, y: placeholderLabel.frame.origin.y - placeholderLabel.frame.size.height - placeholderInsets.y)
        placeholderLabel.textAlignment = .center
        placeholderLabel.backgroundColor = .white
        isFirst = false
    }
    
    // MARK: - Overrides
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.offsetBy(dx: textFieldInsets.x, dy: textFieldInsets.y)
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.offsetBy(dx: textFieldInsets.x, dy: textFieldInsets.y)
    }
}
