//
//  Images.swift
//  Weather
//
//  Created by Дмитрий Никоноров on 02.09.2022.
//

import Foundation
import UIKit

enum Images: String {
    case cloudOne
    case cloudTwo
    case cloudThree
    case mainIllustration
    
    case cloudyBlue
    case cloudyBlueRain
    case cloudyBlueRainSun
    case cloudyBlueThunder
    case cloudyGrey
    case cloudyGreySun
    case crescent
    case rain
    case sunImage
    case thermometerMinus
    case thermometerPlus
    case windImage
    case cloudyGreySunForHeader
    case drops
    case dropsForHeader
    case windForHeader

    var image: UIImage {
        switch self {
        case .cloudOne:
            return UIImage(named: self.rawValue) ?? UIImage()
        case .cloudTwo:
            return UIImage(named: self.rawValue) ?? UIImage()
        case .cloudThree:
            return UIImage(named: self.rawValue) ?? UIImage()
        case .mainIllustration:
            return UIImage(named: self.rawValue) ?? UIImage()
        case .cloudyBlue:
            return UIImage(named: self.rawValue) ?? UIImage()
        case .cloudyBlueRain:
            return UIImage(named: self.rawValue) ?? UIImage()
        case .cloudyBlueRainSun:
            return UIImage(named: self.rawValue) ?? UIImage()
        case .cloudyBlueThunder:
            return UIImage(named: self.rawValue) ?? UIImage()
        case .cloudyGrey:
            return UIImage(named: self.rawValue) ?? UIImage()
        case .cloudyGreySun:
            return UIImage(named: self.rawValue) ?? UIImage()
        case .crescent:
            return UIImage(named: self.rawValue) ?? UIImage()
        case .rain:
            return UIImage(named: self.rawValue) ?? UIImage()
        case .sunImage:
            return UIImage(named: self.rawValue) ?? UIImage()
        case .thermometerMinus:
            return UIImage(named: self.rawValue) ?? UIImage()
        case .thermometerPlus:
            return UIImage(named: self.rawValue) ?? UIImage()
        case .windImage:
            return UIImage(named: self.rawValue) ?? UIImage()
        case .cloudyGreySunForHeader:
            return UIImage(named: self.rawValue) ?? UIImage()
        case .drops:
            return UIImage(named: self.rawValue) ?? UIImage()
        case .dropsForHeader:
            return UIImage(named: self.rawValue) ?? UIImage()
        case .windForHeader:
            return UIImage(named: self.rawValue) ?? UIImage()
        }
    }
}
