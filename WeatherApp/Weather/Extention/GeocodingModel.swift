//
//  GeocodingModel.swift
//  Weather
//
//  Created by Дмитрий Никоноров on 09.09.2022.
//

import Foundation

// MARK: - GeocodingModel
struct GeocodingModel: Codable {
    let response: Response
}
// MARK: - Response
struct Response: Codable {
    let geoObjectCollection: GeoObjectCollection

    enum CodingKeys: String, CodingKey {
        case geoObjectCollection = "GeoObjectCollection"
    }
}
// MARK: - GeoObjectCollection
struct GeoObjectCollection: Codable {
    let featureMember: [FeatureMember]
}
// MARK: - FeatureMember
struct FeatureMember: Codable {
    let geoObject: GeoObjectCoding

    enum CodingKeys: String, CodingKey {
        case geoObject = "GeoObject"
    }
}
// MARK: - GeoObject
struct GeoObjectCoding: Codable {
    let point: Point

    enum CodingKeys: String, CodingKey {
        case point = "Point"
    }
}
// MARK: - Point
struct Point: Codable {
    let pos: String
}
