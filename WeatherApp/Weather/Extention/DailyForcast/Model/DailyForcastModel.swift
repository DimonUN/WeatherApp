//
//  DailyForcastModel.swift
//  Weather
//
//  Created by Дмитрий Никоноров on 14.12.2022.
//

import Foundation
import UIKit

struct DailyForcastModel: ModelProtocol {
    let navigationItemTitle = "Погода на сутки"
    var location: String?
    var oneDayForcastModel: OneDayForcastModel?
    
    struct ViewModel {
        let dayContentViewBackgroundColor: UIColor
        let nightContentViewBackgroundColor: UIColor

        let dayMainText: String
        let dayMainLabelTextColor: UIColor
        let dayMainTextAttributes: [NSAttributedString.Key: Any]?
        let dayMainLabelFont: UIFont

        let dayCloudnessImage: UIImage
        let dayFeelsLikeImage: UIImage
        let dayWindSpeedImage: UIImage
        let dayUVIndexImage: UIImage
        let solarImage: UIImage

        let dayFeelsLikeLabelAttributes: [NSAttributedString.Key: Any]?
        let dayFeelsLikeText: String
        let dayFeelsLikeLabelTextColor: UIColor
        let dayFeelsLikeLabelFont: UIFont

        let dayWindSpeedLabelTextColor: UIColor
        let dayWindSpeedLabelAttributes: [NSAttributedString.Key: Any]?
        let dayWindSpeedText: String
        let dayWindSpeedLabelFont: UIFont

        let dayUVIndexLabelTextColor: UIColor
        let dayUVIndexLabelAttributes: [NSAttributedString.Key: Any]?
        let dayUVIndexText: String
        let dayUVIndexLabelFont: UIFont

        let dayCloudnessLabelTextColor: UIColor
        let dayCloudnessLabelAttributes: [NSAttributedString.Key: Any]?
        let dayCloudnessText: String
        let dayCloudnessLabelFont: UIFont

        let nightMainText: String
        let nightMainLabelTextColor: UIColor
        let nightMainLabelAttributes: [NSAttributedString.Key: Any]?
        let nightMainLabelFont: UIFont

        let nightCloudnessImage: UIImage
        let nightFeelsLikeImage: UIImage
        let nightWindSpeedImage: UIImage
        let nightUVIndexImage: UIImage

        let nightFeelsLikeLabelAttributes: [NSAttributedString.Key: Any]?
        let nightFeelsLikeText: String
        let nightFeelsLikeLabelTextColor: UIColor
        let nightFeelsLikeLabelFont: UIFont

        let nightWindSpeedLabelAttributes: [NSAttributedString.Key: Any]?
        let nightWindSpeedText: String
        let nightWindSpeedLabelTextColor: UIColor
        let nightWindSpeedLabelFont: UIFont

        let nightUVIndexLabelAttributes: [NSAttributedString.Key: Any]?
        let nightUVIndexText: String
        let nightUVIndexLabelTextColor: UIColor
        let nightUVIndexLabelFont: UIFont

        let nightCloudnessLabelAttributes: [NSAttributedString.Key: Any]?
        let nightCloudnessText: String
        let nightCloudnessLabelTextColor: UIColor
        let nightCloudnessLabelFont: UIFont

        let sunTitleLabelAttributes: [NSAttributedString.Key: Any]?
        let sunTitleText: String
        let sunTitleLabelTextColor: UIColor
        let sunTitleLabelFont: UIFont

        let sunriseLabelAttributes: [NSAttributedString.Key: Any]?
        let sunriseText: String
        let sunriseLabelTextColor: UIColor
        let sunriseLabelFont: UIFont

        let sunsetLabelAttributes: [NSAttributedString.Key: Any]?
        let sunsetText: String
        let sunsetLabelTextColor: UIColor
        let sunsetLabelFont: UIFont
    }

    struct ViewModelForcast {
        let dayTempLabelTextColor: UIColor
        let dayTempLabelAttributes: [NSAttributedString.Key: Any]?
        let dayTempLabelFont: UIFont

        let dayConditionLabelTextColor: UIColor
        let dayConditionLabelAttributes: [NSAttributedString.Key: Any]?
        let dayConditionLabelFont: UIFont

        let dayConditionImage: UIImage

        let dayValueFeelsLikeLabelTextColor: UIColor
        let dayValueFeelsLikeLabelAttributes: [NSAttributedString.Key: Any]?
        let dayValueFeelsLikeLabelFont: UIFont

        let dayValueWindSpeedLabelTextColor: UIColor
        let dayValueWindSpeedLabelAttributes: [NSAttributedString.Key: Any]?
        let dayValueWindSpeedLabelFont: UIFont

        let dayValueUVIndexLabelTextColor: UIColor
        let dayValueUVIndexLabelAttributes: [NSAttributedString.Key: Any]?
        let dayValueUVIndexLabelFont: UIFont

        let dayValueCloudnessLabelTextColor: UIColor
        let dayValueCloudnessLabelAttributes: [NSAttributedString.Key: Any]?
        let dayValueCloudnessLabelFont: UIFont

        let nightTempLabelTextColor: UIColor
        let nightTempLabelAttributes: [NSAttributedString.Key: Any]?
        let nightTempLabelFont: UIFont

        let nightConditionLabelTextColor: UIColor
        let nightConditionLabelAttributes: [NSAttributedString.Key: Any]?
        let nightConditionLabelFont: UIFont

        let nightConditionImage: UIImage

        let nightValueFeelsLikeLabelTextColor: UIColor
        let nightValueFeelsLikeLabelAttributes: [NSAttributedString.Key: Any]?
        let nightValueFeelsLikeLabelFont: UIFont

        let nightValueWindSpeedLabelTextColor: UIColor
        let nightValueWindSpeedLabelAttributes: [NSAttributedString.Key: Any]?
        let nightValueWindSpeedLabelFont: UIFont

        let nightValueUVIndexLabelTextColor: UIColor
        let nightValueUVIndexLabelAttributes: [NSAttributedString.Key: Any]?
        let nightValueUVIndexLabelFont: UIFont

        let nightValueCloudnessLabelTextColor: UIColor
        let nightValueCloudnessLabelAttributes: [NSAttributedString.Key: Any]?
        let nightValueCloudnessLabelFont: UIFont

        let sunriseTimeLabelTextColor: UIColor
        let sunriseTimeLabelAttributes: [NSAttributedString.Key: Any]?
        let sunriseTimeLabelFont: UIFont

        let sunsetTimeLabelTextColor: UIColor
        let sunsetTimeLabelAttributes: [NSAttributedString.Key: Any]?
        let sunsetTimeLabelFont: UIFont

        let solarTimeLabelTextColor: UIColor
        let solarTimeLabelAttributes: [NSAttributedString.Key: Any]?
        let solarTimeLabelFont: UIFont
    }
    ///Модель с основными параметрами UI эклементов DailyForecastView
    let viewModel = ViewModel(
        dayContentViewBackgroundColor: Colors.main.color,
        nightContentViewBackgroundColor: Colors.main.color,
        dayMainText: "День",
        dayMainLabelTextColor: Colors.textBlack.color,
        dayMainTextAttributes: Fonts.body3.install.attributes,
        dayMainLabelFont: Fonts.body3.install.font,
        dayCloudnessImage: Images.cloudyBlue.image,
        dayFeelsLikeImage: Images.thermometerPlus.image,
        dayWindSpeedImage: Images.windImage.image,
        dayUVIndexImage: Images.sunImage.image,
        solarImage: Images.sunImage.image,
        dayFeelsLikeLabelAttributes: Fonts.body3.install.attributes,
        dayFeelsLikeText: "По ощущениям",
        dayFeelsLikeLabelTextColor: Colors.textBlack.color,
        dayFeelsLikeLabelFont: Fonts.body3.install.font,
        dayWindSpeedLabelTextColor: Colors.textBlack.color,
        dayWindSpeedLabelAttributes: Fonts.body3.install.attributes,
        dayWindSpeedText: "Ветер",
        dayWindSpeedLabelFont: Fonts.body3.install.font,
        dayUVIndexLabelTextColor: Colors.textBlack.color,
        dayUVIndexLabelAttributes: Fonts.body3.install.attributes,
        dayUVIndexText: "Уф индекс",
        dayUVIndexLabelFont: Fonts.body3.install.font,
        dayCloudnessLabelTextColor: Colors.textBlack.color,
        dayCloudnessLabelAttributes: Fonts.body3.install.attributes,
        dayCloudnessText: "Облачность",
        dayCloudnessLabelFont: Fonts.body3.install.font,
        nightMainText: "Ночь",
        nightMainLabelTextColor: Colors.textBlack.color,
        nightMainLabelAttributes: Fonts.body3.install.attributes,
        nightMainLabelFont: Fonts.body3.install.font,
        nightCloudnessImage: Images.cloudyBlue.image,
        nightFeelsLikeImage: Images.thermometerPlus.image,
        nightWindSpeedImage: Images.windImage.image,
        nightUVIndexImage: Images.sunImage.image,
        nightFeelsLikeLabelAttributes: Fonts.body3.install.attributes,
        nightFeelsLikeText: "По ощущениям",
        nightFeelsLikeLabelTextColor: Colors.textBlack.color,
        nightFeelsLikeLabelFont: Fonts.body3.install.font,
        nightWindSpeedLabelAttributes: Fonts.body3.install.attributes,
        nightWindSpeedText: "Ветер",
        nightWindSpeedLabelTextColor: Colors.textBlack.color,
        nightWindSpeedLabelFont: Fonts.body3.install.font,
        nightUVIndexLabelAttributes: Fonts.body3.install.attributes,
        nightUVIndexText: "Уф индекс",
        nightUVIndexLabelTextColor: Colors.textBlack.color,
        nightUVIndexLabelFont: Fonts.body3.install.font,
        nightCloudnessLabelAttributes: Fonts.body3.install.attributes,
        nightCloudnessText: "Облачность",
        nightCloudnessLabelTextColor: Colors.textBlack.color,
        nightCloudnessLabelFont: Fonts.body3.install.font,
        sunTitleLabelAttributes: Fonts.H3.install.attributes,
        sunTitleText: "Солнце",
        sunTitleLabelTextColor: Colors.textBlack.color,
        sunTitleLabelFont: Fonts.H3.install.font,
        sunriseLabelAttributes: Fonts.H3.install.attributes,
        sunriseText: "Восход",
        sunriseLabelTextColor: Colors.textGrey.color,
        sunriseLabelFont: Fonts.H3.install.font,
        sunsetLabelAttributes: Fonts.H3.install.attributes,
        sunsetText: "Заход",
        sunsetLabelTextColor: Colors.textGrey.color,
        sunsetLabelFont: Fonts.H3.install.font
    )
    ///Модель с параметрами UI элементов прогноза на DailyForecastView
    let viewModelForcast = ViewModelForcast(
        dayTempLabelTextColor: Colors.textBlack.color,
        dayTempLabelAttributes: Fonts.H1.install.attributes,
        dayTempLabelFont: Fonts.H1.install.font,
        dayConditionLabelTextColor: Colors.textBlack.color,
        dayConditionLabelAttributes: Fonts.H2.install.attributes,
        dayConditionLabelFont: Fonts.H2.install.font,
        dayConditionImage: Images.cloudyGrey.image,
        dayValueFeelsLikeLabelTextColor: Colors.textBlack.color,
        dayValueFeelsLikeLabelAttributes: Fonts.H3.install.attributes,
        dayValueFeelsLikeLabelFont: Fonts.H3.install.font,
        dayValueWindSpeedLabelTextColor: Colors.textBlack.color,
        dayValueWindSpeedLabelAttributes: Fonts.body3.install.attributes,
        dayValueWindSpeedLabelFont: Fonts.body3.install.font,
        dayValueUVIndexLabelTextColor: Colors.textBlack.color,
        dayValueUVIndexLabelAttributes: Fonts.body3.install.attributes,
        dayValueUVIndexLabelFont: Fonts.body3.install.font,
        dayValueCloudnessLabelTextColor: Colors.textBlack.color,
        dayValueCloudnessLabelAttributes: Fonts.body3.install.attributes,
        dayValueCloudnessLabelFont: Fonts.body3.install.font,
        nightTempLabelTextColor: Colors.textBlack.color,
        nightTempLabelAttributes: Fonts.H1.install.attributes,
        nightTempLabelFont: Fonts.H1.install.font,
        nightConditionLabelTextColor: Colors.textBlack.color,
        nightConditionLabelAttributes: Fonts.H2.install.attributes,
        nightConditionLabelFont: Fonts.H2.install.font,
        nightConditionImage: Images.cloudyGrey.image,
        nightValueFeelsLikeLabelTextColor: Colors.textBlack.color,
        nightValueFeelsLikeLabelAttributes: Fonts.H3.install.attributes,
        nightValueFeelsLikeLabelFont: Fonts.H3.install.font,
        nightValueWindSpeedLabelTextColor: Colors.textBlack.color,
        nightValueWindSpeedLabelAttributes: Fonts.body3.install.attributes,
        nightValueWindSpeedLabelFont: Fonts.body3.install.font,
        nightValueUVIndexLabelTextColor: Colors.textBlack.color,
        nightValueUVIndexLabelAttributes: Fonts.body3.install.attributes,
        nightValueUVIndexLabelFont: Fonts.body3.install.font,
        nightValueCloudnessLabelTextColor: Colors.textBlack.color,
        nightValueCloudnessLabelAttributes: Fonts.body3.install.attributes,
        nightValueCloudnessLabelFont: Fonts.body3.install.font,
        sunriseTimeLabelTextColor: Colors.textBlack.color,
        sunriseTimeLabelAttributes: Fonts.body.install.attributes,
        sunriseTimeLabelFont: Fonts.body.install.font,
        sunsetTimeLabelTextColor: Colors.textBlack.color,
        sunsetTimeLabelAttributes: Fonts.body.install.attributes,
        sunsetTimeLabelFont: Fonts.body.install.font,
        solarTimeLabelTextColor: Colors.textBlack.color,
        solarTimeLabelAttributes: Fonts.body.install.attributes,
        solarTimeLabelFont: Fonts.body.install.font
    )
}
