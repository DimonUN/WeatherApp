//
//  Fonts.swift
//  Weather
//
//  Created by Дмитрий Никоноров on 30.08.2022.
//

import Foundation
import UIKit

enum Fonts {
    case H1
    case H2
    case H3
    case H4
    case body
    case body2
    case body3
    case caption
    case underlinedBody3

    struct Fonts {
        let font: UIFont
        let attributes: [NSAttributedString.Key: Any]?
    }

    var install: Fonts {
        switch self {
        case .H1:
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = 1.01
            let attributes = [
                NSAttributedString.Key.paragraphStyle: paragraphStyle]
            as [NSAttributedString.Key : Any]
            guard let font = UIFont(name: "Rubik-Regular", size: 30) else {
                let font = UIFont.systemFont(ofSize: 30)
                let fonts = Fonts(font: font, attributes: attributes)
                return fonts
            }
            let fonts = Fonts(font: font, attributes: attributes)
            return fonts
        case .H2:
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = 1.03
            let attributes = [
                NSAttributedString.Key.kern: 0.14,
                NSAttributedString.Key.paragraphStyle: paragraphStyle
            ] as [NSAttributedString.Key : Any]
            guard let font = UIFont(name: "Rubik-Medium", size: 18) else {
                let font = UIFont.systemFont(ofSize: 18)
                let fonts = Fonts(font: font, attributes: attributes)
                return fonts
            }
            let fonts = Fonts(font: font, attributes: attributes)
            return fonts
        case .H3:
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = 1.03
            let attributes = [
                NSAttributedString.Key.kern: 0.14,
                NSAttributedString.Key.paragraphStyle: paragraphStyle
            ] as [NSAttributedString.Key : Any]
            guard let font = UIFont(name: "Rubik-Regular", size: 18) else {
                let font = UIFont.systemFont(ofSize: 18)
                let fonts = Fonts(font: font, attributes: attributes)
                return fonts
            }
            let fonts = Fonts(font: font, attributes: attributes)
            return fonts
        case .H4:
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = 1.03
            let attributes = [
                NSAttributedString.Key.kern: 0.14,
                NSAttributedString.Key.paragraphStyle: paragraphStyle
            ] as [NSAttributedString.Key : Any]
            guard let font = UIFont(name: "Rubik-Medium", size: 36) else {
                let font = UIFont.systemFont(ofSize: 36)
                let fonts = Fonts(font: font, attributes: attributes)
                return fonts
            }
            let fonts = Fonts(font: font, attributes: attributes)
            return fonts
        case .body:
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = 1.05
            let attributes = [
                NSAttributedString.Key.kern: 0.14,
                NSAttributedString.Key.paragraphStyle: paragraphStyle
            ] as [NSAttributedString.Key : Any]
            guard let font = UIFont(name: "Rubik-Regular", size: 16) else {
                let font = UIFont.systemFont(ofSize: 16)
                let fonts = Fonts(font: font, attributes: attributes)
                return fonts
            }
            let fonts = Fonts(font: font, attributes: attributes)
            return fonts
        case .body2:
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = 1.15
            let attributes = [
                NSAttributedString.Key.kern: 0.14,
                NSAttributedString.Key.paragraphStyle: paragraphStyle
            ] as [NSAttributedString.Key : Any]
            guard let font = UIFont(name: "Rubik-Medium", size: 14) else {
                let font = UIFont.systemFont(ofSize: 14)
                let fonts = Fonts(font: font, attributes: attributes)
                return fonts
            }
            let fonts = Fonts(font: font, attributes: attributes)
            return fonts
        case .body3:
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = 1.15
            let attributes = [
                NSAttributedString.Key.kern: 0.14,
                NSAttributedString.Key.paragraphStyle: paragraphStyle
            ] as [NSAttributedString.Key : Any]
            guard let font = UIFont(name: "Rubik-Regular", size: 14) else {
                let font = UIFont.systemFont(ofSize: 14)
                let fonts = Fonts(font: font, attributes: attributes)
                return fonts
            }
            let fonts = Fonts(font: font, attributes: attributes)
            return fonts
        case .caption:
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = 1.13
            let attributes = [
                NSAttributedString.Key.kern: 0.14,
                NSAttributedString.Key.paragraphStyle: paragraphStyle
            ] as [NSAttributedString.Key : Any]
            guard let font = UIFont(name: "Rubik-Regular", size: 12) else {
                let font = UIFont.systemFont(ofSize: 12)
                let fonts = Fonts(font: font, attributes: attributes)
                return fonts
            }
            let fonts = Fonts(font: font, attributes: attributes)
            return fonts
        case .underlinedBody3:
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = 1.15
            let attributes = [
                NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
                NSAttributedString.Key.kern: 0.14,
                NSAttributedString.Key.paragraphStyle: paragraphStyle
            ] as [NSAttributedString.Key : Any]
            guard let font = UIFont(name: "Rubik-Regular", size: 14) else {
                let font = UIFont.systemFont(ofSize: 14)
                let fonts = Fonts(font: font, attributes: attributes)
                return fonts
            }
            let fonts = Fonts(font: font, attributes: attributes)
            return fonts
        }
    }
}
