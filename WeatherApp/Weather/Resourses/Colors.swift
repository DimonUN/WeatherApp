//
//  Colors.swift
//  Weather
//
//  Created by Дмитрий Никоноров on 02.09.2022.
//

import Foundation
import UIKit

enum Colors {
    case white
    case main
    case blue
    case orange
    case green
    case yellow
    case lightGray
    case grey
    case textBlack
    case textGrey
    case textWhite
    case toogleOff

    var color: UIColor {
        switch self {
        case .white:
            return UIColor.white
        case .main:
            return UIColor(red: 0.914, green: 0.933, blue: 0.98, alpha: 1)
        case .blue:
            return UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1)
        case .orange:
            return UIColor(red: 0.949, green: 0.431, blue: 0.067, alpha: 1)
        case .green:
            return UIColor(red: 0.507, green: 0.792, blue: 0.501, alpha: 1)
        case .yellow:
            return UIColor(red: 0.965, green: 0.867, blue: 0.004, alpha: 1)
        case .lightGray:
            return UIColor.lightGray
        case .grey:
            return UIColor(red: 0.31, green: 0.31, blue: 0.31, alpha: 1)
        case .textBlack:
            return UIColor(red: 0.154, green: 0.152, blue: 0.135, alpha: 1)
        case .textGrey:
            return UIColor(red: 0.604, green: 0.587, blue: 0.587, alpha: 1)

        case .textWhite:
            return UIColor(red: 0.973, green: 0.961, blue: 0.961, alpha: 1)
        case .toogleOff:
            return UIColor(red: 0.996, green: 0.929, blue: 0.914, alpha: 1)
        }
    }
}

