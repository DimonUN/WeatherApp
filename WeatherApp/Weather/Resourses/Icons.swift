//
//  Icons.swift
//  Weather
//
//  Created by Дмитрий Никоноров on 02.09.2022.
//

import Foundation
import UIKit

enum Icons: String {
    case bell
    case burger
    case burgerSmall
    case calendar
    case clock
    case editing
    case eye
    case fan
    case geo
    case geoSmall
    case degree
    case humidity
    case next
    case sunIcon
    case sunrise
    case sunset
    case thermometer
    case windIcon
    case arrow

    var icon: UIImage {
        switch self {
        case .bell:
            return UIImage(named: self.rawValue) ?? UIImage()
        case .burger:
            return UIImage(named: self.rawValue) ?? UIImage()
        case .burgerSmall:
            return UIImage(named: self.rawValue) ?? UIImage()
        case .calendar:
            return UIImage(named: self.rawValue) ?? UIImage()
        case .clock:
            return UIImage(named: self.rawValue) ?? UIImage()
        case .editing:
            return UIImage(named: self.rawValue) ?? UIImage()
        case .eye:
            return UIImage(named: self.rawValue) ?? UIImage()
        case .fan:
            return UIImage(named: self.rawValue) ?? UIImage()
        case .geo:
            return UIImage(named: self.rawValue) ?? UIImage()
        case .geoSmall:
            return UIImage(named: self.rawValue) ?? UIImage()
        case .degree:
            return UIImage(named: self.rawValue) ?? UIImage()
        case .humidity:
            return UIImage(named: self.rawValue) ?? UIImage()
        case .next:
            return UIImage(named: self.rawValue) ?? UIImage()
        case .sunIcon:
            return UIImage(named: self.rawValue) ?? UIImage()
        case .sunrise:
            return UIImage(named: self.rawValue) ?? UIImage()
        case .sunset:
            return UIImage(named: self.rawValue) ?? UIImage()
        case .thermometer:
            return UIImage(named: self.rawValue) ?? UIImage()
        case .windIcon:
            return UIImage(named: self.rawValue) ?? UIImage()
        case .arrow:
            return UIImage(named: self.rawValue) ?? UIImage()
        }
    }
}
