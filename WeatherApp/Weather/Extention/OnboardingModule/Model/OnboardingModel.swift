//
//  OnboardingModel.swift
//  Weather
//
//  Created by Дмитрий Никоноров on 11.09.2022.
//

import Foundation
import UIKit

struct OnboardingModel {
    struct ViewModel: ModelProtocol {
        ///mainImageView
        let mainViewImage: UIImage
        ///titleLabel
        let titleLabelFont: UIFont
        let titleLabelTextColor: UIColor
        let titleLabelText: String
        let titleLabelAttributes: [NSAttributedString.Key: Any]?
        ///firstTextLabel
        let firstTextLabelFont: UIFont
        let firstTextLabelTextColor: UIColor
        let firstTextLabelText: String
        let firstTextLabelAttributes: [NSAttributedString.Key: Any]?
        ///secondTextLabel
        let secondTextLabelFont: UIFont
        let secondTextLabelTextColor: UIColor
        let secondTextLabelText: String
        let secondTextLabelAttributes: [NSAttributedString.Key: Any]?
        ///accessButton
        let accessButtonTitleFont: UIFont
        let accessButtonText: String
        let accessButtonAttributes: [NSAttributedString.Key: Any]?
        let accessButtonTitleColor: UIColor
        let accessButtonBackgroundColor: UIColor
        ///declineButton
        let declineButtonTitleFont: UIFont
        let declineButtonText: String
        let declineButtonAttributes: [NSAttributedString.Key: Any]?
        let declineButtonTitleColor: UIColor
    }
    
    let viewModel = ViewModel(
        mainViewImage: Images.mainIllustration.image,
        titleLabelFont: Fonts.body.install.font,
        titleLabelTextColor: Colors.textWhite.color,
        titleLabelText: "Разрешить приложению  Weather использовать данные \nо местоположении вашего устройства",
        titleLabelAttributes: Fonts.body.install.attributes,
        firstTextLabelFont: Fonts.body3.install.font,
        firstTextLabelTextColor: Colors.textWhite.color,
        firstTextLabelText: "Чтобы получить более точные прогнозы \nпогоды во время движения или путешествия",
        firstTextLabelAttributes: Fonts.body3.install.attributes,
        secondTextLabelFont: Fonts.body3.install.font,
        secondTextLabelTextColor: Colors.textWhite.color,
        secondTextLabelText: "Вы можете изменить свой выбор в любое \nвремя из меню приложения",
        secondTextLabelAttributes: Fonts.body3.install.attributes,
        accessButtonTitleFont: Fonts.caption.install.font,
        accessButtonText: "ИСПОЛЬЗОВАТЬ МЕСТОПОЛОЖЕНИЕ  УСТРОЙСТВА",
        accessButtonAttributes: Fonts.caption.install.attributes,
        accessButtonTitleColor: Colors.textWhite.color,
        accessButtonBackgroundColor: Colors.orange.color,
        declineButtonTitleFont: Fonts.body.install.font,
        declineButtonText: "НЕТ, Я БУДУ ДОБАВЛЯТЬ ЛОКАЦИИ",
        declineButtonAttributes: Fonts.body.install.attributes,
        declineButtonTitleColor: Colors.textWhite.color
    )
}
