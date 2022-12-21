//
//  HeaderModel.swift
//  Weather
//
//  Created by Дмитрий Никоноров on 15.11.2022.
//

import Foundation

struct HeaderForcastModel: ModelProtocol {
    let currentForcast: String
    let currentTemperature: String
    let temperatureRangeFrom: String
    let temperatureRangeTo: String
    let timeOfSunrise: String
    let timeOfSunset: String
    let uvIndex: String
    let wind: String
    let humidity: String
    let currentDate: String
}



