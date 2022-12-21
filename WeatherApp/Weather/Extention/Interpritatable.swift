//
//  Interpritatable.swift
//  Weather
//
//  Created by Дмитрий Никоноров on 19.11.2022.
//

import Foundation
import UIKit

protocol Interpritatable {
    ///Интерпритатор прогноза
    func conditionInterpritator(condition: String) -> String
    ///Интерпритатор времени
    func timeInterpritator(time: String?) -> String
    ///Интерпритатор фазы луны
    func moonCodeInterpritator(moonCode: Int) -> String
    ///Интерпритатор силы осадков
    func precStrengthInterpritator(strength: Double?, withType type: Int?) -> String
    ///Интерпритатор облачности
    func cloudnessInterpritator(cloudness: Double?) -> String
    ///Интерпритатор направления ветра
    func windDirectionInterpritator(windDir: String?) -> String
    ///Интерпритатор изображения
    func imageInterpritator(condition: String) -> UIImage
    ///Интерпритатор даты для OneDayForcast ячейки
    func dateInterpritatorForOneDayForcast(dateFromDataBaseModel date: String) -> String
    ///Форматирование даты
    func formattingFromISO8601(date: String, with timeFormat: FormatOfTime) -> String
    ///Перевести цельсии в файренгейты
    func convertTemperature(temperature : Int, to tempSystem: TemperatireSystem) -> String
    ///Перевести m/s в yd/s
    func convertSpeed(speed: Double, to speedSystem: WindSpeedSystem) -> String
}
