//
//  UIResponder+Extension.swift
//  tip-calculator
//
//  Created by Heonjin Ha on 2023/05/07.
//

import UIKit

extension UIResponder {

    var parentViewController: UIViewController? {
        return next as? UIViewController ?? next?.parentViewController
    }

}
