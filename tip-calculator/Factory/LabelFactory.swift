//
//  LabelFactory.swift
//  tip-calculator
//
//  Created by Heonjin Ha on 2023/05/02.
//

import UIKit

struct LabelFactory {

    static func build(text: String, alignment: NSTextAlignment = .center, font: UIFont) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = font
        label.textAlignment = alignment

        return label
    }

    static func build(attributedText: NSAttributedString, alignment: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = attributedText
        label.textAlignment = alignment

        return label
    }

}
