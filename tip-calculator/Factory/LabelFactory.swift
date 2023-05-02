//
//  LabelFactory.swift
//  tip-calculator
//
//  Created by Heonjin Ha on 2023/05/02.
//

import UIKit

struct LabelFactory {

    static func build(text: String, alignment: NSTextAlignment, font: UIFont) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.textAlignment = .center

        return label
    }

    static func build(attributedText: NSAttributedString, alignment: NSTextAlignment, font: UIFont) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = attributedText
        label.textAlignment = .center

        return label
    }

}
