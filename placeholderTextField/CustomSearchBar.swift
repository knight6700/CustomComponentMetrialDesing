//
//  CustomSearchBar.swift
//  placeholderTextField
//
//  Created by Mahmoud Fares on 17/05/2021.
//

import UIKit

class CustomSearchBar: UISearchBar {

    var preferredFont: UIFont!
    
    var preferredTextColor: UIColor!
    private let borderLayer = CALayer()

    
    override func draw(_ rect: CGRect) {
        if let index = indexOfSearchFieldInSubviews() {
            let searchField: UITextField = (subviews[0] ).subviews[index] as! UITextField
            searchField.frame = CGRect(x: 5.0, y: 8, width: frame.size.width - 10.0, height: frame.size.height - 16.0)
            
            searchField.font = preferredFont
            searchField.textColor = preferredTextColor
            
            searchField.clipsToBounds = true
            searchField.layer.cornerRadius = 15.0
            
            searchField.layer.borderWidth = 2
            searchField.layer.borderColor = UIColor(red: 37.0 / 255.0, green: 71.0 / 255.0, blue: 112.0 / 255.0, alpha: 1).cgColor
            
            searchField.backgroundColor = barTintColor
            
            if let glassIconView = searchField.leftView as? UIImageView {
                glassIconView.image = glassIconView.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
                glassIconView.tintColor = UIColor(red: 70.0 / 255.0, green: 174.0 / 255.0, blue: 218.0 / 255.0, alpha: 1)
            }

        }
        
        let startPoint = CGPoint(x: 0.0, y: frame.size.height)
        let endPoint = CGPoint(x: frame.size.width, y: frame.size.height)
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addLine(to: endPoint)
        searchTextField.backgroundColor = .white
        self.inputView?.backgroundColor = .white
        self.searchBarStyle = .default
        self.backgroundImage = UIImage()
        self.barTintColor = .green
        layer.insertSublayer(borderLayer, at: 0)
        updateBorder()
        
        super.draw(rect)
    }
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


    
    init(frame: CGRect, font: UIFont, textColor: UIColor) {
        super.init(frame: frame)
        
        self.frame = frame
        preferredFont = font
        preferredTextColor = textColor
        
        searchBarStyle = UISearchBar.Style.prominent
        isTranslucent = false
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func indexOfSearchFieldInSubviews() -> Int! {
        print(subviews[0].subviews)
        var index: Int!
        let searchBarView = subviews[0]
        for i in 0..<searchBarView.subviews.count {
            if searchBarView.subviews[i].isKind(of: UITextField.self) {
                index = i
                break
            }
        }
        return index
    }
}
