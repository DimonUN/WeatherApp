//
//  DatabaseCoordinatable.swift
//  Weather
//
//  Created by Дмитрий Никоноров on 12.09.2022.
//

import Foundation
import CoreData

enum DatabaseError: Error {
/// Невозможно добавить хранилище
    case store(model: String)
/// Не найден файл momd
    case find(model: String, bundle: Bundle?)
/// Не найдена модель объекта
    case wrongModel
/// Кастомная ошибка
    case error(description: String)
/// Неизвестная ошибка
    case unknown(error: Error)
}

protocol DatabaseCoordinatable {
    func getMainContext() -> NSManagedObjectContext


    func create(weather: WeatherModel, fact: Fact, geoObject: GeoObject, forecasts: [Forecasts], partsHours: [PartsHour], hours: [Hour], completion: @escaping (Result<[NSManagedObject], DatabaseError>) -> Void)


    func delete(_ model: NSManagedObject.Type, predicate: NSPredicate?, completion: @escaping (Result<[NSManagedObject], DatabaseError>) -> Void)

    func deleteAll(_ model: NSManagedObject.Type, completion: @escaping (Result<[NSManagedObject], DatabaseError>) -> Void)

    func fetch(_ model: NSManagedObject.Type, predicate: NSPredicate?, completion: @escaping (Result<[NSManagedObject], DatabaseError>) -> Void)

    func fetchAll(_ model: NSManagedObject.Type, completion: @escaping (Result<[NSManagedObject], DatabaseError>) -> Void)
}

