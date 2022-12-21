//
//  Defaults.swift
//  Weather
//
//  Created by Дмитрий Никоноров on 10.11.2022.
//

import Foundation

enum TemperatireSystem: Int {
    case celsius = 1
    case fahrenheit = 2
}

enum WindSpeedSystem: Int {
    case metersPerSecond = 1
    case yardPerSecond = 2
}

enum FormatOfTime: Int {
    case _12h = 1
    case _24h = 2
}

final class Defaults {
    private enum SettingsKeys: String {
        case isRequestShow
        case geolocationState
        case userLocation

        case tempCalculationSystem
        case windSpeedSystem
        case timeFormat
    }
    ///Впервые ли запущено приложение
    static var isRequestShow: Bool? {
        get {
            return UserDefaults.standard.bool(forKey: SettingsKeys.isRequestShow.rawValue)
        } set {
            let defaults = UserDefaults.standard
            let key = SettingsKeys.isRequestShow.rawValue
            if let value = newValue {
                defaults.set(value, forKey: key)
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
    ///Дал ли пользователь разрешение на использование гео данных
    static var geolocationState: GeolocationState? {
        get {
            let result = UserDefaults.standard.integer(forKey: SettingsKeys.geolocationState.rawValue)
            return GeolocationState(rawValue: result)
        } set {
            let defaults = UserDefaults.standard
            let key = SettingsKeys.geolocationState.rawValue
            if let value = newValue {
                defaults.set(value.rawValue, forKey: key)
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
    ///Локация добавленная пользователем
    static var userlLocation: String? {
        get {
            return UserDefaults.standard.string(forKey: SettingsKeys.userLocation.rawValue)
        } set {
            let defaults = UserDefaults.standard
            let key = SettingsKeys.userLocation.rawValue
            if let value = newValue {
                defaults.set(value, forKey: key)
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
    ///Единицы измерения температуры
    static var tempCalculationSystem: TemperatireSystem {
        get {
            let result = UserDefaults.standard.integer(forKey: SettingsKeys.tempCalculationSystem.rawValue)
            return TemperatireSystem(rawValue: result) ?? .celsius
        } set {
            let defaults = UserDefaults.standard
            let key = SettingsKeys.tempCalculationSystem.rawValue
            defaults.set(newValue.rawValue, forKey: key)
        }
    }
    ///Единицы скорости ветра
    static var windSpeedSystem: WindSpeedSystem {
        get {
            let result = UserDefaults.standard.integer(forKey: SettingsKeys.windSpeedSystem.rawValue)
            return WindSpeedSystem(rawValue: result) ?? .metersPerSecond
        } set {
            let defaults = UserDefaults.standard
            let key = SettingsKeys.windSpeedSystem.rawValue
            defaults.set(newValue.rawValue, forKey: key)
        }
    }
    ///Формат времени
    static var timeFormat: FormatOfTime {
        get {
            let result = UserDefaults.standard.integer(forKey: SettingsKeys.timeFormat.rawValue)
            return FormatOfTime(rawValue: result) ?? ._24h
        } set {
            let defaults = UserDefaults.standard
            let key = SettingsKeys.timeFormat.rawValue
            defaults.set(newValue.rawValue, forKey: key)
        }
    }
}
