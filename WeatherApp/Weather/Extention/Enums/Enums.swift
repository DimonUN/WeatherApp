//
//  Enums.swift
//  Weather
//
//  Created by Дмитрий Никоноров on 13.12.2022.
//

import Foundation
///Состояние разрешение на получение геолокации
enum GeolocationState: Int {
    ///Разрешение получено
    case geolocationAllowed = 0
    ///Разрешение не получено
    case geolocationNotAllowed = 1
}
///ReuseIdentifiers для таблицы
enum TableReuseIdentifiers: String {
    case threeHourForcast
    case oneDayForcast
    case defaultCell
}
///ReuseIdentifiers для коллекции
enum CollectionReuseIdentifiers: String {
    case threeHourForcat
}

