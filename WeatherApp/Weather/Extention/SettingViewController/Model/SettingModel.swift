//
//  SettingModel.swift
//  Weather
//
//  Created by Дмитрий Никоноров on 21.12.2022.
//

import Foundation
import UIKit

struct SettingModel {
    struct ViewModel: ModelProtocol {
        let viewBackgroundColor: UIColor
        let cloudOneImage: UIImage
        let cloudTwoImage: UIImage
        let cloudThreeImage: UIImage
        let contentViewBackgroundColor: UIColor

        let titleLableFont: UIFont
        let titleLableTextColor: UIColor
        let titleLableText: String
        let titleLableAttributes: [NSAttributedString.Key: Any]?

        let temperatureLabelFont: UIFont
        let temperatureLabelTextColor: UIColor
        let temperatureLabelText: String
        let temperatureLabelAttributes: [NSAttributedString.Key: Any]?

        let windSpeedLabelFont: UIFont
        let windSpeedLabelTextColor: UIColor
        let windSpeedLabelText: String
        let windSpeedLabelAttributes: [NSAttributedString.Key: Any]?

        let timeFormatLabelFont: UIFont
        let timeFormatLabelTextColor: UIColor
        let timeFormatLabelText: String
        let timeFormatLabelAttributes: [NSAttributedString.Key: Any]?

        let setupButtonTitleText: String
        let setupButtonTitleAttributes: [NSAttributedString.Key: Any]?

        let setupButtonTitleLabelFont: UIFont
        let setupButtonTitleColor: UIColor
        let setupButtonBackgroundColor: UIColor

        let notificationLabelFont: UIFont
        let notificationLabelTextColor: UIColor
        let notificationLabelText: String
        let notificationLabelAttributes: [NSAttributedString.Key: Any]?

        let temperatureSegmentedControlBackgroundColor: UIColor
        let temperatureSegmentedControlSelectedTintColor: UIColor
        let temperatureSegmentedControlTitleTextColor: UIColor

        let windSpeedSegmentedControlBackgroundColor: UIColor
        let windSpeedSegmentedControlSelectedTintColor: UIColor
        let windSpeedSegmentedControlTitleTextColor: UIColor

        let timeFormatSegmentedControlBackgroundColor: UIColor
        let timeFormatSegmentedControlSelectedTintColor: UIColor
        let timeFormatSegmentedControlTitleTextColor: UIColor

        let notificationSegmentedControlBackgroundColor: UIColor
        let notificationSegmentedControlSelectedTintColor: UIColor
        let notificationSegmentedControlTitleTextColor: UIColor
    }

    let viewModel = ViewModel(
        viewBackgroundColor: Colors.blue.color,
        cloudOneImage: Images.cloudOne.image,
        cloudTwoImage: Images.cloudTwo.image,
        cloudThreeImage: Images.cloudThree.image,
        contentViewBackgroundColor: Colors.main.color,
        titleLableFont: Fonts.H2.install.font,
        titleLableTextColor: Colors.textBlack.color,
        titleLableText: "Настройки",
        titleLableAttributes: Fonts.H2.install.attributes,
        temperatureLabelFont: Fonts.body.install.font,
        temperatureLabelTextColor: Colors.textGrey.color,
        temperatureLabelText: "Температра",
        temperatureLabelAttributes: Fonts.body.install.attributes,
        windSpeedLabelFont: Fonts.body.install.font,
        windSpeedLabelTextColor: Colors.textGrey.color,
        windSpeedLabelText: "Скорость ветра",
        windSpeedLabelAttributes: Fonts.body.install.attributes,
        timeFormatLabelFont: Fonts.body.install.font,
        timeFormatLabelTextColor: Colors.textGrey.color,
        timeFormatLabelText: "Формат времени",
        timeFormatLabelAttributes: Fonts.body.install.attributes,
        setupButtonTitleText: "Установить",
        setupButtonTitleAttributes: Fonts.body.install.attributes,
        setupButtonTitleLabelFont: Fonts.body.install.font,
        setupButtonTitleColor: Colors.textWhite.color,
        setupButtonBackgroundColor: Colors.orange.color,
        notificationLabelFont: Fonts.body.install.font,
        notificationLabelTextColor: Colors.textGrey.color,
        notificationLabelText: "Уведомления",
        notificationLabelAttributes: Fonts.body.install.attributes,
        temperatureSegmentedControlBackgroundColor: Colors.toogleOff.color,
        temperatureSegmentedControlSelectedTintColor: Colors.blue.color,
        temperatureSegmentedControlTitleTextColor: Colors.white.color,
        windSpeedSegmentedControlBackgroundColor: Colors.toogleOff.color,
        windSpeedSegmentedControlSelectedTintColor: Colors.blue.color,
        windSpeedSegmentedControlTitleTextColor: Colors.white.color,
        timeFormatSegmentedControlBackgroundColor: Colors.toogleOff.color,
        timeFormatSegmentedControlSelectedTintColor: Colors.blue.color,
        timeFormatSegmentedControlTitleTextColor: Colors.white.color,
        notificationSegmentedControlBackgroundColor: Colors.toogleOff.color,
        notificationSegmentedControlSelectedTintColor: Colors.blue.color,
        notificationSegmentedControlTitleTextColor: Colors.white.color
    )
}
