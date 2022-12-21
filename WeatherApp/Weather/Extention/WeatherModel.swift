//
//  Forecat.swift
//  WeatherModel
//
//  Created by Дмитрий Никоноров on 09.09.2022.
//

import Foundation

// MARK: - WeatherModel
struct WeatherModel: Codable {
    let now: Int
    let nowDt: String
    let geoObjectFromForcast: GeoObject
    let fact: Fact
    let forecasts: [Forecasts?]

    enum CodingKeys: String, CodingKey {
        case fact
        case now
        case nowDt = "now_dt"
        case geoObjectFromForcast = "geo_object"
        case forecasts
    }

    var keyedValues: [String: Any] {
        return [
            "now": self.now,
            "nowDt": self.nowDt
        ]
    }

    init?(weatherDataModel: WeatherDataModel) {
        self.now = Int(weatherDataModel.now)
        self.nowDt = weatherDataModel.nowDt ?? ""
        //Создание модели данных Fact
        guard let factDataModelArray = weatherDataModel.fact?.allObjects as? [FactDataModel] else { return nil }
        let factAray = factDataModelArray.map { Fact(factDataModel: $0) }
        guard factAray.count > 0 else { return nil }
        let fact = factAray[0]
        self.fact = fact
        //Создание модели данных GeoObject
        guard let geoObjectDataModelArray = weatherDataModel.geoObject?.allObjects as? [GeoObjectDataModel] else { return nil }
        let geoObjectArray = geoObjectDataModelArray.map { GeoObject(geoObject: $0)}
        let geoObject = geoObjectArray[0]
        self.geoObjectFromForcast = geoObject
        //Создание массива данных Forecasts
        guard let forecastsDataModelArray = weatherDataModel.forecasts?.allObjects as? [ForecastsDataModel] else { return nil }
        let forecasts = forecastsDataModelArray.map { Forecasts(forecasts: $0) }
        self.forecasts = forecasts
    }

    init(
        now: Int,
        nowDt: String,
        geoObjectFromForcast: GeoObject,
        fact: Fact,
        forecasts: [Forecasts]
    ) {
        self.now = now
        self.nowDt = nowDt
        self.geoObjectFromForcast = geoObjectFromForcast
        self.fact = fact
        self.forecasts = forecasts
    }
}
// MARK: - Fact
struct Fact: Codable {
    let obsTime: Int
    let temp: Int
    let feelsLike: Int
    let icon: String
    let condition: String
    let cloudness: Double
    let precType: Int
    let precStrength: Double?
    let windSpeed: Double
    let windDir: String
    let humidity: Int
    let daytime: String
    let uvIndex: Int

    enum CodingKeys: String, CodingKey {
        case obsTime = "obs_time"
        case temp
        case feelsLike = "feels_like"
        case icon, condition, cloudness
        case precType = "prec_type"
        case precStrength = "prec_strength"
        case windSpeed = "wind_speed"
        case windDir = "wind_dir"
        case humidity, daytime
        case uvIndex = "uv_index"
    }

    var keyedValues: [String: Any] {
        return [
            "obsTime": self.obsTime,
            "temp": self.temp,
            "feelsLike": self.feelsLike,
            "icon": self.icon,
            "condition": self.condition,
            "cloudness": self.cloudness,
            "precType": self.precType,
            "precStrength": self.precStrength ?? 0.0,
            "windSpeed": self.windSpeed,
            "windDir": self.windDir,
            "humidity": self.humidity,
            "daytime": self.daytime,
            "uvIndex": self.uvIndex,
        ]
    }

    init(factDataModel: FactDataModel) {
        self.obsTime = Int(factDataModel.obsTime)
        self.temp = Int(factDataModel.temp)
        self.feelsLike = Int(factDataModel.feelsLike)
        self.icon = factDataModel.icon ?? ""
        self.condition = factDataModel.condition ?? ""
        self.cloudness = factDataModel.cloudness
        self.precType = Int(factDataModel.precType)
        self.precStrength = factDataModel.precStrength
        self.windSpeed = factDataModel.windSpeed
        self.windDir = factDataModel.windDir ?? ""
        self.humidity = Int(factDataModel.humidity)
        self.daytime = factDataModel.daytime ?? ""
        self.uvIndex = Int(factDataModel.uvIndex)
    }

    init(
        obsTime: Int,
        temp: Int,
        feelsLike: Int,
        icon: String,
        condition: String,
        cloudness: Double,
        precType: Int,
        precStrength: Double?,
        windSpeed: Double,
        windDir: String,
        humidity: Int,
        daytime: String,
        uvIndex: Int
    ) {
        self.obsTime = obsTime
        self.temp = temp
        self.feelsLike = feelsLike
        self.icon = icon
        self.condition = condition
        self.cloudness = cloudness
        self.precType = precType
        self.precStrength = precStrength
        self.windSpeed = windSpeed
        self.windDir = windDir
        self.humidity = humidity
        self.daytime = daytime
        self.uvIndex = uvIndex
    }
}
// MARK: - Forecast
struct Forecasts: Codable {
    let date: String
    let dateTs: Int
    let sunrise, sunset, riseBegin, setEnd: String
    let moonCode: Int
    let parts: Parts
    let hours: [Hour]
    let condition: String?

    enum CodingKeys: String, CodingKey {
        case date
        case dateTs = "date_ts"
        case sunrise, sunset
        case riseBegin = "rise_begin"
        case setEnd = "set_end"
        case moonCode = "moon_code"
        case parts, hours
        case condition
    }

    var keyedValues: [String: Any] {
        return [
            "date": self.date,
            "dateTs": self.dateTs,
            "sunrise": self.sunrise,
            "sunset": self.sunset,
            "riseBegin": self.riseBegin,
            "setEnd": self.setEnd,
            "moonCode": self.moonCode
        ]
    }

    init?(forecasts: ForecastsDataModel) {
        self.date = forecasts.date ?? ""
        self.dateTs = Int(forecasts.dateTs)
        self.sunrise = forecasts.sunrise ?? ""
        self.sunset = forecasts.sunset ?? ""
        self.riseBegin = forecasts.riseBegin ?? ""
        self.setEnd = forecasts.setEnd ?? ""
        self.moonCode = Int(forecasts.moonCode)
        self.condition = ""
        ///Создание PartsHour
        ///Создание Day
        ///Моздание массива PartsHourDataModel
        var dayPartsHour = PartsHour()
        if let partsHourDataModel = forecasts.day?.allObjects as? [PartsHourDataModel] {
            ///Создание массива PartsHour
            let dayPartsHourArray = partsHourDataModel.map { PartsHour(partsHour: $0) }
            ///Создание PartsHour
            dayPartsHour = dayPartsHourArray[0]
        }
        ///Создание Night
        ///Создание массива PartsHourDataModel
        var nightPartsHour = PartsHour()
        if let partsHourDataModel = forecasts.night?.allObjects as? [PartsHourDataModel] {
            ///Создание массива PartsHour
            let nightPartsHourArray = partsHourDataModel.map { PartsHour(partsHour: $0) }
            ///Создание PartsHour
            if nightPartsHourArray.count > 0 {
                nightPartsHour = nightPartsHourArray[0]
            }
        }
        ///Создаем модель Parts
        let parts = Parts(day: dayPartsHour, night: nightPartsHour)
        self.parts = parts

        guard let hourDataModelArray = forecasts.hours?.allObjects as? [HourDataModel] else { return nil }
        ///Создание массива Hour для конкрентной модели Forecasts
        let hours = hourDataModelArray.map { Hour(hour: $0) }
        self.hours = hours
    }

    init(
        date: String,
        dateTs: Int,
        sunrise: String,
        sunset: String,
        riseBegin: String,
        setEnd: String,
        moonCode: Int,
        parts: Parts,
        hours: [Hour]
    ) {
        self.date = date
        self.dateTs = dateTs
        self.sunrise = sunrise
        self.sunset = sunset
        self.riseBegin = riseBegin
        self.setEnd = setEnd
        self.moonCode = moonCode
        self.parts = parts
        self.hours = hours
        self.condition = ""
    }
}
// MARK: - Hour
struct Hour: Codable {
    let hour: String?
    let hourTs, temp: Int?
    let feelsLike: Int
    let icon: String
    let condition: String
    let cloudness: Double
    let precType: Int
    let precStrength: Double
    let windDir: String
    let windSpeed: Double
    let humidity: Int
    let uvIndex: Int?
    let tempMin, tempAvg, tempMax: Int?
    let daytime: String?
    var date: String?

    enum CodingKeys: String, CodingKey {
        case hour
        case hourTs = "hour_ts"
        case temp
        case feelsLike = "feels_like"
        case icon, condition, cloudness
        case precType = "prec_type"
        case precStrength = "prec_strength"
        case windDir = "wind_dir"
        case windSpeed = "wind_speed"
        case humidity
        case uvIndex = "uv_index"
        case tempMin = "temp_min"
        case tempAvg = "temp_avg"
        case tempMax = "temp_max"
        case daytime
    }

    var keyedValues: [String: Any] {
        return [
            "hour": self.hour ?? .empty,
            "hourTs": self.hourTs ?? .zero,
            "temp": self.temp ?? .zero,
            "feelsLike": self.feelsLike,
            "icon": self.icon,
            "condition": self.condition,
            "cloudness": self.cloudness,
            "precType": self.precType,
            "precStrength": self.precStrength,
            "windDir": self.windDir,
            "windSpeed": self.windSpeed,
            "humidity": self.humidity,
            "uvIndex": self.uvIndex ?? .zero,
            "tempMin": self.tempMin ?? .zero,
            "tempAvg": self.tempAvg ?? .zero,
            "tempMax": self.tempMax ?? .zero,
            "daytime": self.daytime ?? .empty,
            "date": self.date ?? .empty
        ]
    }

    init(hour: HourDataModel) {
        self.hour = hour.hour
        self.hourTs = Int(hour.hourTs)
        self.temp = Int(hour.temp)
        self.feelsLike = Int(hour.feelsLike)
        self.icon = hour.icon ?? ""
        self.condition = hour.condition ?? ""
        self.cloudness = hour.cloudness
        self.precType = Int(hour.precType)
        self.precStrength = hour.precStrength
        self.windDir = hour.windDir ?? ""
        self.windSpeed = hour.windSpeed
        self.humidity = Int(hour.humidity)
        self.uvIndex = Int(hour.uvIndex)
        self.tempMin = Int(hour.tempMin)
        self.tempAvg = Int(hour.tempAvg)
        self.tempMax = Int(hour.tempMax)
        self.daytime = hour.daytime
        self.date = hour.date
    }

    init(
        hour: String?,
        hourTs: Int?,
        temp: Int?,
        feelsLike: Int,
        icon: String,
        condition: String,
        cloudness: Double,
        precType: Int,
        precStrength: Double,
        windDir: String,
        windSpeed: Double,
        humidity: Int,
        uvIndex: Int?,
        tempMin: Int?,
        tempAvg: Int?,
        tempMax: Int?,
        daytime: String?,
        date: String?
    ) {
        self.hour = hour
        self.hourTs = hourTs
        self.temp = temp
        self.feelsLike = feelsLike
        self.icon = icon
        self.condition = condition
        self.cloudness = cloudness
        self.precType = precType
        self.precStrength = precStrength
        self.windDir = windDir
        self.windSpeed = windSpeed
        self.humidity = humidity
        self.uvIndex = uvIndex
        self.tempMin = tempMin
        self.tempAvg = tempAvg
        self.tempMax = tempMax
        self.daytime = daytime
        self.date = date
    }
}
// MARK: - PartsHour
struct PartsHour: Codable {
    let source: String
    let feelsLike: Int
    let icon: String
    let condition: String
    let cloudness: Double
    let precType: Int
    let precStrength: Double
    let windDir: String
    let windSpeed: Double
    let humidity: Int
    let uvIndex: Int?
    let tempMin, tempAvg, tempMax: Int?
    let daytime: String?
    var date: String?

    enum CodingKeys: String, CodingKey {
        case source = "_source"
        case feelsLike = "feels_like"
        case icon, condition, cloudness
        case precType = "prec_type"
        case precStrength = "prec_strength"
        case windDir = "wind_dir"
        case windSpeed = "wind_speed"
        case humidity
        case uvIndex = "uv_index"
        case tempMin = "temp_min"
        case tempAvg = "temp_avg"
        case tempMax = "temp_max"
        case daytime
    }

    var keyedValues: [String: Any] {
        return [
            "source": self.source,
            "feelsLike": self.feelsLike,
            "icon": self.icon,
            "condition": self.condition,
            "cloudness": self.cloudness,
            "precType": self.precType,
            "precStrength": self.precStrength,
            "windDir": self.windDir,
            "windSpeed": self.windSpeed,
            "humidity": self.humidity,
            "uvIndex": self.uvIndex ?? .zero,
            "tempMin": self.tempMin ?? .zero,
            "tempAvg": self.tempAvg ?? .zero,
            "tempMax": self.tempMax ?? .zero,
            "daytime": self.daytime ?? .empty,
            "date": self.date ?? .empty
        ]
    }

    init(partsHour: PartsHourDataModel) {
        self.source = partsHour.source ?? ""
        self.feelsLike = Int(partsHour.feelsLike)
        self.icon = partsHour.icon ?? ""
        self.condition = partsHour.condition ?? ""
        self.cloudness = partsHour.cloudness
        self.precType = Int(partsHour.precType)
        self.precStrength = partsHour.precStrength
        self.windDir = partsHour.windDir ?? ""
        self.windSpeed = partsHour.windSpeed
        self.humidity = Int(partsHour.humidity)
        self.uvIndex = Int(partsHour.uvIndex)
        self.tempMin = Int(partsHour.tempMin)
        self.tempAvg = Int(partsHour.tempAvg)
        self.tempMax = Int(partsHour.tempMax)
        self.daytime = partsHour.daytime
        self.date = partsHour.date
    }

    init(
        source: String,
        feelsLike: Int,
        icon: String,
        condition: String,
        cloudness: Double,
        precType: Int,
        precStrength: Double,
        windDir: String,
        windSpeed: Double,
        humidity: Int,
        uvIndex: Int?,
        tempMin:Int?,
        tempAvg: Int?,
        tempMax: Int?,
        daytime: String?,
        date: String?
    ) {
        self.source = source
        self.feelsLike = feelsLike
        self.icon = icon
        self.condition = condition
        self.cloudness = cloudness
        self.precType = precType
        self.precStrength = precStrength
        self.windDir = windDir
        self.windSpeed = windSpeed
        self.humidity = humidity
        self.uvIndex = uvIndex
        self.tempMin = tempMin
        self.tempAvg = tempAvg
        self.tempMax = tempMax
        self.daytime = daytime
        self.date = date
    }

    init() {
        source = ""
        feelsLike = 0
        icon = ""
        condition = ""
        cloudness = 0
        precType = 0
        precStrength = 0
        windDir = ""
        windSpeed = 0
        humidity = 0
        uvIndex = nil
        tempMin = nil
        tempAvg = nil
        tempMax = nil
        daytime = nil
        date = nil
    }
}
// MARK: - Parts
struct Parts: Codable {
    let day: PartsHour
    let night: PartsHour

    enum CodingKeys: String, CodingKey {
        case day, night
    }

    init(
        day: PartsHour,
        night: PartsHour
    ) {
        self.day = day
        self.night = night
    }
}
// MARK: - GeoObject
struct GeoObject: Codable {
    let district: Country
    let locality: Country
    let province: Country
    let country: Country
    var keyedValues: [String: Any] {
        return [
            "district": self.district.name ?? .empty,
            "locality": self.locality.name ?? .empty,
            "province": self.province.name ?? .empty,
            "country": self.country.name ?? .empty
        ]
    }

    init(geoObject: GeoObjectDataModel) {
        let district = Country(name: geoObject.district)
        let locality = Country(name: geoObject.locality)
        let province = Country(name: geoObject.province)
        let country = Country(name: geoObject.country)

        self.district = district
        self.locality = locality
        self.province = province
        self.country = country
    }

    init(
        district: Country,
        locality: Country,
        province: Country,
        country: Country
    ) {
        self.district = district
        self.locality = locality
        self.province = province
        self.country = country
    }
}
// MARK: - Country
struct Country: Codable {
    let name: String?

    enum CodingKeys: String, CodingKey {
        case name
    }

    var keyedValues: [String: Any] {
        return [
            "name": self.name ?? .empty
        ]
    }

    init(
        name: String?
    ) {
        self.name = name
    }
}

enum Condition: String, Codable {
    case clear = "clear"
    case cloudy = "cloudy"
    case lightRain = "light-rain"
    case overcast = "overcast"
    case partlyCloudy = "partly-cloudy"
    case drizzle = "drizzle"
    case rain = "rain"
    case moderateRain = "moderate-rain"
    case heavyRain = "heavy-rain"
    case continuousHeavyRain = "continuous-heavy-rain"
    case showers = "showers"
    case wetSnow = "wet-snow"
    case lightSnow = "light-snow"
    case snow = "snow"
    case snowShowers = "snow-showers"
    case hail = "hail"
    case thunderstorm = "thunderstorm"
    case thunderstormWithRain = "thunderstorm-with-rain"
    case thunderstormWithHail = "thunderstorm-with-hail"

    var keyedValues: [String: Any] {
        return [
            "clear": Condition.clear,
            "cloudy": Condition.cloudy,
            "lightRain": Condition.lightRain,
            "overcast": Condition.overcast,
            "partlyCloudy": Condition.partlyCloudy,
            "drizzle": Condition.drizzle,
            "rain": Condition.rain,
            "moderateRain": Condition.moderateRain,
            "heavyRain": Condition.heavyRain,
            "continuousHeavyRain": Condition.continuousHeavyRain,
            "showers": Condition.showers,
            "wetSnow": Condition.wetSnow,
            "lightSnow": Condition.lightSnow,
            "snow": Condition.snow,
            "snowShowers": Condition.snowShowers,
            "hail": Condition.hail,
            "thunderstorm": Condition.thunderstorm,
            "thunderstormWithRain": Condition.thunderstormWithRain,
            "thunderstormWithHail": Condition.thunderstormWithHail
        ]
    }
}

enum Daytime: String, Codable {
    case d = "d"
    case n = "n"
}

enum WindDir: String, Codable {
    case nw = "nw"
    case n = "n"
    case ne = "ne"
    case e = "e"
    case se = "se"
    case s = "s"
    case sw = "sw"
    case w = "w"
    case с = "с"
}
