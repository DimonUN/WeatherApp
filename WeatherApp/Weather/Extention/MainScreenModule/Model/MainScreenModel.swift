//
//  MainScreenModel.swift
//  Weather
//
//  Created by Дмитрий Никоноров on 13.12.2022.
//

import Foundation
import UIKit

struct MainScreenModel {
    ///Данные для view
    struct ViewModel: ModelProtocol {
        let fillViewBbackgroundColor: UIColor
        let bottomViewBackgroundColor: UIColor
        let viewBackgroundColor: UIColor
    }
    ///Данные для контроллера
    struct Controller {
        let viewBackgroundColor: UIColor

        let titleWithoutGeolocation: String
        let rightBarButtonImage: UIImage
        let leftBarButtonImage: UIImage
        let rightBarButtonTintColor: UIColor
        let leftBarButtonItemTintColor: UIColor

        let alertAddCityTitle: String
        let alertAddCityPlaceholder: String
        let alertAddCityActionTitle: String
        let alertAddCityCancelTitle: String

        let alertFindTitle: String
        let alertFindMessageStart: String
        let alertFindMessageEnd: String
        let alertFindActionTitle: String
        let alertFindCanceltitle: String
    }
    ///Данные для ячейки коллекции ThreeHourForcastCollectionViewCell
    struct ThreeHourCollectionCellModel {
        let timeLabelTextColor: UIColor
        let timeLabelFont: UIFont
        let weatherImage: UIImage
        let temperatureLabelTextColor: UIColor
        let temperatureLabelFont: UIFont
        let degreeViewBorderColor: UIColor
        let contentViewBorderColor: UIColor
    }
    ///Данные для ячейк таблицы OneDayForcastTableViewCell
    struct OneDayForcastTableCellModel {
        let dateLabelTextColor: UIColor
        let dateLabelFont: UIFont

        let humidityLabelTextColor: UIColor
        let humidityLabelFont: UIFont

        let mainForcastLabelTextColor: UIColor
        let mainForcastLabelFont: UIFont

        let temperatureFromLabelTextColor: UIColor
        let temperatureFromLabelFont: UIFont

        let temperatureToLabelTextColor: UIColor
        let temperatureToLabelFont: UIFont

        let degreeIconFromViewBorderColor: UIColor
        let degreeIconToViewBorderColor: UIColor

        let nextIconImage: UIImage

        let backgroundUIViewColor: UIColor
    }
    ///Данные для хэдера
    struct HeaderModel: ModelProtocol {
        let contentViewBackgroundColor: UIColor
        let decorArcViewBorderColor: UIColor
        let cutterArcViewBackgroundColor: UIColor

        let timeOfSunriseLabelTextColor: UIColor
        let timeOfSunriseLabelFont: UIFont

        let timeOfSunsetLabelTextColor: UIColor
        let timeOfSunsetLabelFont: UIFont

        let sunriseImageViewImage: UIImage
        let sunriseImageViewColor: UIColor

        let sunsetImageViewImage: UIImage
        let sunsetImageViewColor: UIColor

        let temperatureRangeFromLabelTextColor: UIColor
        let temperatureRangeFromLabelFont: UIFont

        let temperatureRangeToLabelTextColor: UIColor
        let temperatureRangeToLabelFont: UIFont

        let currentTemperatureLabelTextColor: UIColor
        let currentTemperatureLabelFont: UIFont

        let currentForcastLabelTextColor: UIColor
        let currentForcastLabelFont: UIFont

        let uvIndexLabelTextColor: UIColor
        let uvIndexLabelFont: UIFont

        let windLabelTextColor: UIColor
        let windLabelFont: UIFont

        let humidityLabelTextColor: UIColor
        let humidityLabelFont: UIFont

        let currentDateLabelTextColor: UIColor
        let currentDateLabelFont: UIFont

        let degreeCurrenViewBorderColor: UIColor

        let degreeFromViewBorderColor: UIColor

        let degreeToViewBorderColor: UIColor
    }
    ///Данные для меню
    struct MenuUIModel: ModelProtocol {
        let contentViewBackgroundColor: UIColor

        let weatherImage: UIImage

        let weatherTitleLabelFont: UIFont
        let weatherTitleLabelTextColor: UIColor

        let weatherTitleLabelText: String
        let weatherTitleLabelAttributes: [NSAttributedString.Key: Any]?

        let separationLineBackgroundColor: UIColor

        let editLabelFont: UIFont
        let editLabelTextColor: UIColor
        let editLabelText: String

        let editImage: UIImage
        let editImageColor: UIColor


        let geoLabelFont: UIFont
        let geoLabelTextColor: UIColor

        let geoImage: UIImage
        let geoImageColor: UIColor

        let notificationLabelFont: UIFont
        let notificationLabelTextColor: UIColor

        let notificationLabelText: String
        let notificationLabelAttributes: [NSAttributedString.Key: Any]?

        let notificationImage: UIImage
        let notificationImageColor: UIColor

        let daytimeWeatherLabelFont: UIFont
        let daytimeWeatherLabelTextColor: UIColor
        let daytimeWeatherLabelText: String
        let daytimeWeatherLabelTextAttributes: [NSAttributedString.Key: Any]?

        let daytimeWeatherImage: UIImage
        let daytimeWeatherImageColor: UIColor

        let temperatureTitleLabelFont: UIFont
        let temperatureTitleLabelTextColor: UIColor

        let temperatureTitleLabelText: String
        let temperatureTitleLabelAttributes: [NSAttributedString.Key: Any]?

        let temperatureImage: UIImage
        let temperatureImageColor: UIColor

        let windSpeedTitleLabelFont: UIFont
        let windSpeedTitleLabelTextColor: UIColor

        let windSpeedTitleLabelText: String
        let windSpeedTitleLabelAttributes: [NSAttributedString.Key: Any]?

        let windSpeedImage: UIImage
        let windSpeedImageColor: UIColor

        let visibilityTitleLabelFont: UIFont
        let visibilityTitleLabelTextColor: UIColor

        let visibilityTitleLabelText: String
        let visibilityTitleLabelAttributes: [NSAttributedString.Key: Any]?

        let visibilityImage: UIImage
        let visibilityImageColor: UIColor

        let timeFormatLabelFont: UIFont
        let timeFormatLabelTextColor: UIColor

        let timeFormatLabelText: String
        let timeFormatLabelTextAttributes: [NSAttributedString.Key: Any]?

        let timeFormatImage: UIImage
        let timeFormatImageColor: UIColor

        let dateFormatLabelFont: UIFont
        let dateFormatLabelTextColor: UIColor

        let dateFormatLabelText: String
        let dateFormatLabelAttributes: [NSAttributedString.Key: Any]?

        let dateFormatImage: UIImage
        let dateFormatImageColor: UIColor

        let temperatureUnitLabelFont: UIFont
        let temperatureUnitLabelTextColor: UIColor

        let windSpeedUnitLabelFont: UIFont
        let windSpeedUnitLabelTextColor: UIColor

        let visibilityUnitLabelFont: UIFont
        let visibilityUnitLabelTextColor: UIColor

        let timeFormatUnitLabelFont: UIFont
        let timeFormatUnitLabelTextColor: UIColor

        let dateFormatUnitLabelFont: UIFont
        let dateFormatUnitLabelTextColor: UIColor

        let dateFormatUnitLabelText: String
        let dateFormatUnitLabelAttributes: [NSAttributedString.Key: Any]?

        let changebleModel: ChangebleModel
    }
    struct ChangebleModel {
        let celsiusTempText: String
        let fahrenheitTempText: String
        let temperatureUnitLabelAttributes: [NSAttributedString.Key: Any]?

        let metersPerSecondWindText: String
        let yardPerSecondWindText: String
        let windSpeedUnitLabelAttributes: [NSAttributedString.Key: Any]?

        let visibilityUnitLabelText: String
        let visibilityUnitLabelAttributes: [NSAttributedString.Key: Any]?

        let timeFormatText12: String
        let timeFormatText24: String
        let timeFormatUnitLabelAttributes: [NSAttributedString.Key: Any]?
    }
    ///Модель для view
    let viewModel = ViewModel(
        fillViewBbackgroundColor: Colors.lightGray.color,
        bottomViewBackgroundColor: Colors.blue.color,
        viewBackgroundColor: Colors.white.color
    )
    ///Модель для контроллера
    let controllerModel = Controller(
        viewBackgroundColor: Colors.white.color,
        titleWithoutGeolocation: "Добавьте локацию",
        rightBarButtonImage: Icons.geoSmall.icon,
        leftBarButtonImage: Icons.burgerSmall.icon,
        rightBarButtonTintColor: Colors.textBlack.color,
        leftBarButtonItemTintColor: Colors.textBlack.color,
        alertAddCityTitle: "Введите город",
        alertAddCityPlaceholder: "Введите город",
        alertAddCityActionTitle: "Добавить",
        alertAddCityCancelTitle: "Отменить",
        alertFindTitle: "Ошибка",
        alertFindMessageStart: "Город по запросу",
        alertFindMessageEnd: "не найден",
        alertFindActionTitle: "Ввести коректный город",
        alertFindCanceltitle: "Отменить"
    )
    ///Модель для ячейки коллекции ThreeHourForcastCollectionViewCell
    let threeHourCollectionCellModel = ThreeHourCollectionCellModel(
        timeLabelTextColor: Colors.textBlack.color,
        timeLabelFont: Fonts.body3.install.font,
        weatherImage: Images.sunImage.image,
        temperatureLabelTextColor: Colors.grey.color,
        temperatureLabelFont: Fonts.body.install.font,
        degreeViewBorderColor: Colors.textGrey.color,
        contentViewBorderColor: Colors.blue.color
    )
    ///Модель для ячейк таблицы OneDayForcastTableViewCell
    let oneDayForcastTableCellModel = OneDayForcastTableCellModel(
        dateLabelTextColor: Colors.textGrey.color,
        dateLabelFont: Fonts.body.install.font,
        humidityLabelTextColor: Colors.blue.color,
        humidityLabelFont: Fonts.caption.install.font,
        mainForcastLabelTextColor: Colors.textBlack.color,
        mainForcastLabelFont: Fonts.body.install.font,
        temperatureFromLabelTextColor: Colors.textBlack.color,
        temperatureFromLabelFont: Fonts.H3.install.font,
        temperatureToLabelTextColor: Colors.textBlack.color,
        temperatureToLabelFont: Fonts.H3.install.font,
        degreeIconFromViewBorderColor: Colors.textGrey.color,
        degreeIconToViewBorderColor: Colors.textGrey.color,
        nextIconImage: Icons.next.icon,
        backgroundUIViewColor: Colors.main.color
    )
    ///Модель для хедера
    let headerModel = HeaderModel(
        contentViewBackgroundColor: Colors.blue.color,
        decorArcViewBorderColor: Colors.yellow.color,
        cutterArcViewBackgroundColor: Colors.blue.color,
        timeOfSunriseLabelTextColor: Colors.textWhite.color,
        timeOfSunriseLabelFont: Fonts.body2.install.font,
        timeOfSunsetLabelTextColor: Colors.textWhite.color,
        timeOfSunsetLabelFont: Fonts.body2.install.font,
        sunriseImageViewImage: Icons.sunrise.icon,
        sunriseImageViewColor: Colors.yellow.color,
        sunsetImageViewImage: Icons.sunset.icon,
        sunsetImageViewColor: Colors.yellow.color,
        temperatureRangeFromLabelTextColor: Colors.textWhite.color,
        temperatureRangeFromLabelFont: Fonts.body.install.font,
        temperatureRangeToLabelTextColor: Colors.textWhite.color,
        temperatureRangeToLabelFont: Fonts.body.install.font,
        currentTemperatureLabelTextColor: Colors.textWhite.color,
        currentTemperatureLabelFont: Fonts.H4.install.font,
        currentForcastLabelTextColor: Colors.textWhite.color,
        currentForcastLabelFont: Fonts.body.install.font,
        uvIndexLabelTextColor: Colors.textWhite.color,
        uvIndexLabelFont: Fonts.body3.install.font,
        windLabelTextColor: Colors.textWhite.color,
        windLabelFont: Fonts.body3.install.font,
        humidityLabelTextColor: Colors.textWhite.color,
        humidityLabelFont: Fonts.body3.install.font,
        currentDateLabelTextColor: Colors.yellow.color,
        currentDateLabelFont: Fonts.body.install.font,
        degreeCurrenViewBorderColor: Colors.white.color,
        degreeFromViewBorderColor: Colors.white.color,
        degreeToViewBorderColor: Colors.white.color
    )
    ///Модель для меню
    let changebleModel = ChangebleModel(
        celsiusTempText: "C",
        fahrenheitTempText: "F",
        temperatureUnitLabelAttributes: Fonts.underlinedBody3.install.attributes,
        metersPerSecondWindText: "м/с",
        yardPerSecondWindText: "я/с",
        windSpeedUnitLabelAttributes: Fonts.underlinedBody3.install.attributes,
        visibilityUnitLabelText: "Км",
        visibilityUnitLabelAttributes: Fonts.underlinedBody3.install.attributes,
        timeFormatText12: "12 часов",
        timeFormatText24: "24 часа",
        timeFormatUnitLabelAttributes: Fonts.underlinedBody3.install.attributes
    )
    lazy var menuUIModel = MenuUIModel(
        contentViewBackgroundColor: Colors.blue.color,
        weatherImage: Images.cloudyGreySunForHeader.image,
        weatherTitleLabelFont: Fonts.H2.install.font,
        weatherTitleLabelTextColor: Colors.textWhite.color,
        weatherTitleLabelText: "WeatherApp",
        weatherTitleLabelAttributes: Fonts.H2.install.attributes,
        separationLineBackgroundColor: Colors.white.color,
        editLabelFont: Fonts.body3.install.font,
        editLabelTextColor: Colors.textWhite.color,
        editLabelText: "Редактировать",
        editImage: Icons.editing.icon,
        editImageColor: Colors.white.color,
        geoLabelFont: Fonts.body3.install.font,
        geoLabelTextColor: Colors.textWhite.color,
        geoImage: Icons.geo.icon,
        geoImageColor: Colors.white.color,
        notificationLabelFont: Fonts.body3.install.font,
        notificationLabelTextColor: Colors.textWhite.color,
        notificationLabelText:"Уведомление",
        notificationLabelAttributes: Fonts.body3.install.attributes,
        notificationImage: Icons.bell.icon,
        notificationImageColor: Colors.white.color,
        daytimeWeatherLabelFont: Fonts.body3.install.font,
        daytimeWeatherLabelTextColor: Colors.textWhite.color,
        daytimeWeatherLabelText: "Дневная погода",
        daytimeWeatherLabelTextAttributes: Fonts.body3.install.attributes,
        daytimeWeatherImage: Icons.sunIcon.icon,
        daytimeWeatherImageColor: Colors.white.color,
        temperatureTitleLabelFont: Fonts.body3.install.font,
        temperatureTitleLabelTextColor: Colors.textWhite.color,
        temperatureTitleLabelText: "Единица температуры",
        temperatureTitleLabelAttributes: Fonts.body3.install.attributes,
        temperatureImage: Icons.thermometer.icon,
        temperatureImageColor: Colors.white.color,
        windSpeedTitleLabelFont: Fonts.body3.install.font,
        windSpeedTitleLabelTextColor: Colors.textWhite.color,
        windSpeedTitleLabelText: "Единица скорости ветра",
        windSpeedTitleLabelAttributes: Fonts.body3.install.attributes,
        windSpeedImage: Icons.fan.icon,
        windSpeedImageColor: Colors.white.color,
        visibilityTitleLabelFont: Fonts.body3.install.font,
        visibilityTitleLabelTextColor: Colors.textWhite.color,
        visibilityTitleLabelText: "Блок видимости",
        visibilityTitleLabelAttributes: Fonts.body3.install.attributes,
        visibilityImage: Icons.eye.icon,
        visibilityImageColor: Colors.white.color,
        timeFormatLabelFont: Fonts.body3.install.font,
        timeFormatLabelTextColor: Colors.textWhite.color,
        timeFormatLabelText: "Формат времени",
        timeFormatLabelTextAttributes: Fonts.body3.install.attributes,
        timeFormatImage: Icons.clock.icon,
        timeFormatImageColor: Colors.white.color,
        dateFormatLabelFont: Fonts.body3.install.font,
        dateFormatLabelTextColor: Colors.textWhite.color,
        dateFormatLabelText: "Формат даты",
        dateFormatLabelAttributes: Fonts.body3.install.attributes,
        dateFormatImage: Icons.calendar.icon,
        dateFormatImageColor: Colors.white.color,
        temperatureUnitLabelFont: Fonts.underlinedBody3.install.font,
        temperatureUnitLabelTextColor: Colors.textWhite.color,
        windSpeedUnitLabelFont: Fonts.underlinedBody3.install.font,
        windSpeedUnitLabelTextColor: Colors.textWhite.color,
        visibilityUnitLabelFont: Fonts.underlinedBody3.install.font,
        visibilityUnitLabelTextColor: Colors.textWhite.color,
        timeFormatUnitLabelFont: Fonts.underlinedBody3.install.font,
        timeFormatUnitLabelTextColor: Colors.textWhite.color,
        dateFormatUnitLabelFont: Fonts.underlinedBody3.install.font,
        dateFormatUnitLabelTextColor: Colors.textWhite.color,
        dateFormatUnitLabelText: "mm/dd/yy",
        dateFormatUnitLabelAttributes: Fonts.underlinedBody3.install.attributes,
        changebleModel: changebleModel
    )

}

