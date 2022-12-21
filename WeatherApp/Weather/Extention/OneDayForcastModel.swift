//
//  OneDayForcastModel.swift
//  Weather
//
//  Created by Дмитрий Никоноров on 17.11.2022.
//

import Foundation
import UIKit

struct OneDayForcastModel {
    ///Дата
    let date: String?
    ///Основной прогноз
    let condition: String?
    ///Влажность
    let humidity: Int?
    ///Температура от
    let tempMin: String?
    ///Температура до
    let tempMax: String?
    ///Изображение
    let image: UIImage

    //День
    ///Прогноз
    let dayCondition: String?
    ///Температура
    let dayTemp: String?
    ///По ощущениям
    let dayFeelsLike: String?
    ///Ветер скорость
    let dayWindSpeed: String?
    ///Направление
    let dayWindDirection: String?
    ///Уф индекс
    let dayUVIndex: Int?
    ///Сила осадков
    let dayPrecStrength: String?
    ///Облачность %
    let dayCloudness: String?

    //Ночь
    ///Прогноз
    let nightCondition: String?
    ///Температура
    let nightTemp: String?
    ///По ощущениям
    let nightFeelsLike: String?
    ///Ветер скорость
    let nightWindSpeed: String?
    ///Направление
    let nightWindDirection: String?
    ///Уф индекс
    let nightUVIndex: Int?
    ///Сила осадков
    let nightPrecStrength: String?
    ///Облачность %
    let nightCloudness: String?

    ///Фаза луны
    let moonCode: String?
    ///Восход солнца
    let sunrise: String?
    ///Заход солнца
    let sunset: String?
}
