//
//  Font.swift
//  tip-calculator
//
//  Created by Heonjin Ha on 2023/05/02.
//

import UIKit

enum AppFont {

    static func regular(size: CGFloat = 16) -> UIFont {
        return UIFont(name: "Avenir Medium", size: size)
        ?? UIFont.systemFont(ofSize: size)
    }

    static func bold(size: CGFloat = 16) -> UIFont {
        return UIFont(name: "Avenir Next Bold", size: size)
        ?? UIFont.systemFont(ofSize: size)
    }

    static func demiBold(size: CGFloat = 16) -> UIFont {
        return UIFont(name: "Avenir Next Demi Bold", size: size)
        ?? UIFont.systemFont(ofSize: size)
    }

}
