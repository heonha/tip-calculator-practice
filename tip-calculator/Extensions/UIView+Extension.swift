//
//  UIView+Extension.swift
//  tip-calculator
//
//  Created by Heonjin Ha on 2023/05/05.
//

import UIKit

extension UIView {

    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {

        self.layer.cornerRadius = radius
        self.layer.masksToBounds = false
        self.layer.shadowOffset = offset
        self.layer.shadowColor = color.cgColor
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity

        let backgroundCGColor = self.backgroundColor?.cgColor
        self.backgroundColor = nil
        self.layer.backgroundColor = backgroundCGColor

    }

    func addCornerRadius(radius: CGFloat) {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = radius
    }
}
