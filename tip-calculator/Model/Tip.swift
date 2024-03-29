//
//  Tip.swift
//  tip-calculator
//
//  Created by Heonjin Ha on 2023/05/05.
//

import Foundation

enum Tip {
    case none
    case tenPercent
    case fiftenPercent
    case twentyPercent
    case custom(value: Int)

    var stringValue: String {
        switch self {
        case .none:
            return ""
        case .tenPercent:
            return "10%"
        case .fiftenPercent:
            return "15%"
        case .twentyPercent:
            return "20%"
        case .custom(let value):
            return "\(value)"
        }
    }
}
