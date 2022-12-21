//
//  Interpritator.swift
//  Weather
//
//  Created by Дмитрий Никоноров on 19.11.2022.
//

import Foundation
import UIKit

class Interpritator: Interpritatable {
    ///Интерпритатор прогноза
    func conditionInterpritator(condition: String) -> String {
        switch condition {
        case "clear":
            return "Ясно"
        case "partly-cloudy":
            return "Малооблачно"
        case "cloudy":
            return "Облачно с прояснениями"
        case "overcast":
            return "Пасмурно"
        case "drizzle":
            return "Морось"
        case "light-rai":
            return "Небольшой дождь"
        case "rain":
            return "Дождь"
        case "moderate-rain":
            return "Умеренно сильный дождь"
        case "heavy-rain":
            return "Сильный дождь"
        case "continuous-heavy-rain":
            return "Длительный сильный дождь"
        case "showers":
            return "Ливень"
        case "wet-snow":
            return "Дождь со снегом"
        case "light-snow":
            return "Небольшой снег"
        case "snow":
            return "Снег"
        case "snow-showers":
            return "Снегопад"
        case "hail":
            return "Град"
        case "thunderstorm":
            return "Гроза"
        case "thunderstorm-with-rain":
            return "Дождь с грозой"
        case "thunderstorm-with-hail":
            return "Гроза с градом"
        default:
            return ""
        }
    }
    ///Интерпритатор времени
    func timeInterpritator(time: String?) -> String {
        guard let time = time else { return "" }
        let separator = ":"
        let minutes = "00"
        let additionalZero = "0"
        if time.count == 1 {
            let newTime = additionalZero + time + separator + minutes
            return newTime
        } else {
            let newTime = time + separator + minutes
            return newTime
        }
    }
    ///Интерпритатор фазы луны
    func moonCodeInterpritator(moonCode: Int) -> String {
        switch moonCode {
        case 0:
            return "Полнолуние"
        case 1, 2, 3:
            return "Убывающая Луна"
        case 4:
            return "Последняя четверть убывающей Луны"
        case 5, 6, 7:
            return "Убывающая Луна"
        case 8:
            return "Новолуние"
        case 9, 10, 11:
            return "Растущая Луна"
        case 12:
            return "Первая четверть растущей Луны"
        case 13, 14, 15:
            return "Растущая Луна"
        default:
            return ""
        }
    }
    ///Интерпритатор силы осадков
    func precStrengthInterpritator(strength: Double?, withType type: Int?) -> String {
        guard let strength = strength else { return "" }
        guard let type = type else { return "" }
        switch strength {
        case 0..<0.25:
            return "Без осадков"
        case 0.25..<0.5:
            if type == 1 {
                return "Cлабый дождь"
            } else if type == 2 {
                return "Слабый дождь со снегом"
            } else if type == 3 {
                return "Слабый снег"
            } else if type == 4 {
                return "Слабый град"
            } else {
                return ""
            }
        case 0.5..<0.75:
            if type == 1 {
                return "Дождь"
            } else if type == 2 {
                return "Дождь со снегом"
            } else if type == 3 {
                return "Снег"
            } else if type == 4 {
                return "Град"
            } else {
                return ""
            }
        case 0.75...1:
            if type == 1 {
                return "Сильный дождь"
            } else if type == 2 {
                return "Сильный дождь со снегом"
            } else if type == 3 {
                return "Сильный снег"
            } else if type == 4 {
                return "Сильный град"
            } else {
                return ""
            }
        default:
            return ""
        }
    }
    ///Интерпритатор облачности
    func cloudnessInterpritator(cloudness: Double?) -> String {
        guard let cloudness = cloudness else { return "" }
        switch cloudness {
        case 0..<0.25:
            return "Ясно"
        case 0.25..<0.5:
            return "Малооблачно"
        case 0.5...0.75:
            return "Облачно с прояснениями"
        case 0.76...1:
            return "Пасмурно"
        default:
            return ""
        }
    }
    ///Интерпритатор направления ветра
    func windDirectionInterpritator(windDir: String?) -> String {
        guard let windDir = windDir else { return "" }
        switch windDir {
        case "nw":
            return "СЗ"
        case "n":
            return "С"
        case "ne":
            return "СВ"
        case "e":
            return "В"
        case "se":
            return "ЮВ"
        case "s":
            return "Ю"
        case "sw":
            return "ЮЗ"
        case "w":
            return "З"
        case "c":
            return "Ш"
        default:
            return ""
        }
    }
    ///Интерпритатор изображения
    func imageInterpritator(condition: String) -> UIImage {
        switch condition {
        case "clear":
            return Images.sunImage.image
        case "partly-cloudy":
            return Images.cloudyGrey.image
        case "cloudy":
            return Images.cloudyGreySun.image
        case "overcast":
            return Images.cloudyBlue.image
        case "drizzle":
            return Images.cloudyBlueRain.image
        case "light-rai":
            return Images.cloudyBlueRain.image
        case "rain":
            return Images.drops.image
        case "moderate-rain":
            return Images.drops.image
        case "heavy-rain":
            return Images.rain.image
        case "continuous-heavy-rain":
            return Images.rain.image
        case "showers":
            return Images.rain.image
        case "wet-snow":
            //return "Дождь со снегом"
            return Images.cloudyBlueThunder.image
        case "light-snow":
//            return "Небольшой снег"
            return Images.cloudyBlueThunder.image
        case "snow":
//            return "Снег"
            return Images.cloudyBlueThunder.image
        case "snow-showers":
//            return "Снегопад"
            return Images.cloudyBlueThunder.image
        case "hail":
//            return "Град"
            return Images.cloudyBlueThunder.image
        case "thunderstorm":
//            return "Гроза"
            return Images.cloudyBlueThunder.image
        case "thunderstorm-with-rain":
//            return "Дождь с грозой"
            return Images.cloudyBlueThunder.image
        case "thunderstorm-with-hail":
//            return "Гроза с градом"
            return Images.cloudyBlueThunder.image
        default:
            return UIImage()
        }
    }
    ///Интерпритатор даты для OneDayForcast ячейки
    func dateInterpritatorForOneDayForcast(dateFromDataBaseModel date: String) -> String {
        let result: [String] =  date.components(separatedBy: ["-"])
        let day = result[2]
        let month = result[1]
        let newDate = day + "/" + month
        return newDate
    }
    ///Форматирование даты
    func formattingFromISO8601(date: String, with timeFormat: FormatOfTime) -> String {
        ///from ISO8601
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions.insert(.withFractionalSeconds)
        let formattingDate = formatter.date(from: date) //Optional(2022-11-19 13:13:18 +0000) Date
        ///from 2022-11-19 13:13:18 +0000
        let myFormatter = DateFormatter()
        switch timeFormat {
        case ._12h:
            myFormatter.dateFormat = "h:mm a',' E dd, MMMM"
            let newDate = myFormatter.string(from: formattingDate ?? Date())
            return newDate
        case ._24h:
            myFormatter.dateFormat = "HH:mm',' E dd, MMMM"
            let newDate = myFormatter.string(from: formattingDate ?? Date())
            return newDate
        }
    }
    ///Перевести цельсии в файренгейты
    func convertTemperature(temperature : Int, to tempSystem: TemperatireSystem) -> String {
        switch tempSystem {
        case .celsius:
            return String(temperature)
        case .fahrenheit:
            let fTemp = temperature * 9 / 5 + 32
            return String(fTemp)
        }
    }
    ///Перевести m/s в yd/s
    func convertSpeed(speed: Double, to speedSystem: WindSpeedSystem) -> String {
        switch speedSystem {
        case .metersPerSecond:
            return String(speed) + " " + "м/с"
        case .yardPerSecond:
            let newSpeed = Double(speed) * 1.094
            return String(round(newSpeed * 10)/10) + " " + "ярд/с"
        }
    }
}
