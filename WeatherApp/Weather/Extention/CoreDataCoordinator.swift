//
//  CoreDataCoordinator.swift
//  Weather
//
//  Created by Дмитрий Никоноров on 12.09.2022.
//

import Foundation
import CoreData

enum Extensions: String {
    case momd
}

enum DatabaseName: String {
    case database = "Database"
}

enum CoreDataModelNames: String {
    case WeatherDataModel
    case FactDataModel
    case GeoObjectDataModel
    case ForecastsDataModel
    case HourDataModel
    case PartsHourDataModel
}

private enum CompletionHandlerType {
    case success
    case failure(error: DatabaseError)
}

final class CoreDataCoordinator {
    let modelName: String
    private let model: NSManagedObjectModel
    private let persistentStoreCoordinator: NSPersistentStoreCoordinator

    private lazy var saveContext: NSManagedObjectContext = {
        let saveContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        saveContext.parent = self.mainContext
        saveContext.mergePolicy = NSOverwriteMergePolicy
        return saveContext
    }()

    private lazy var mainContext: NSManagedObjectContext = {
        let mainContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        mainContext.parent = self.masterContext
        mainContext.mergePolicy = NSOverwriteMergePolicy
        return mainContext
    }()

    private lazy var masterContext: NSManagedObjectContext = {
        let masterContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        masterContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        masterContext.mergePolicy = NSOverwriteMergePolicy
        return masterContext
    }()

    init(nameOfDataModelResource resource: String, withExtension name: Extensions) throws {
        let bundle = Bundle.main
        guard let url = bundle.url(forResource: resource, withExtension: name.rawValue) else {
            fatalError("Can't find Database.xcdatamodeld in main Bundle")
        }
        let pathExtention = url.pathExtension
        ///Получаем с помощью расширения имя CoreDataModel, которое у нас Database.xcdatamodeld
        guard let name = try? url.lastPathComponent.replace(pathExtention, replacement: "") else {
            throw DatabaseError.error(description: "")
        }
        /// Создаем модель NSManagedObjectModel на основе DataModel модели по URL
        guard let model = NSManagedObjectModel(contentsOf: url) else {
            throw DatabaseError.error(description: "Неудалось создать NSManagedObjectModel на основе DataModel")
        }
        self.modelName = name //Database
        self.model = model
        self.persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        setup()
    }

    private func setup() {
        ///Создаем файл менеджер
        let fileManager = FileManager.default
        ///Создаем имя для нашей БД
        let storeName = "\(modelName)" + "sqlite" //Database.sqlite
        ///Создаем URL на директорию documentDirectory
        let documentsDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        ///Создаем путь для нашей БД
        let persistentStoreURL = documentsDirectoryURL?.appendingPathComponent(storeName)

        do {
            ///Создаем опции
            let options = [
                NSMigratePersistentStoresAutomaticallyOption: true,
                NSInferMappingModelAutomaticallyOption: true
            ]
            /// В наш NSPersistentStoreCoordinator добавляем Store, т.е. БД
            try persistentStoreCoordinator.addPersistentStore(
                ///Тип
                ofType: NSSQLiteStoreType,
                ///Конфигурации
                configurationName: nil,
                ///созданный ранее путь для хранения БД
                at: persistentStoreURL,
                ///Созданные ранее опции
                options: options
            )
        } catch {
            _ = DatabaseError.store(model: modelName)
        }
    }
    private func handler(
        for type: CompletionHandlerType,
        using context: NSManagedObjectContext,
        contextWorkInOwnQueue: Bool = true,
        with completionHandler: (() -> Void)?,
        and failureCompletion: ((DatabaseError) -> Void)?
    ) {
        switch type {
        case .success:
            if context.concurrencyType == .mainQueueConcurrencyType {
                if contextWorkInOwnQueue {
                    completionHandler?()
                } else {
                    self.mainContext.perform {
                        completionHandler?()
                    }
                }
            }
        case .failure(let error):
            if context.concurrencyType == .privateQueueConcurrencyType {
                if context.parent != nil {
                    self.mainContext.perform {
                        failureCompletion?(error)
                    }
                }
            } else {
                if contextWorkInOwnQueue {
                    failureCompletion?(error)
                } else {
                    failureCompletion?(error)
                }
            }
        }
    }

    private func save(
        with context: NSManagedObjectContext,
        completionHandler: (() -> Void)? = nil,
        failureCompletion: ((DatabaseError) -> Void)? = nil
    ) {
        guard context.hasChanges else {
            if context.parent != nil {
                self.handler(
                    for: .failure(error: .error(description: "Context has not change!")),
                    using: context,
                    contextWorkInOwnQueue: false,
                    with: completionHandler,
                    and: failureCompletion
                )
            }
            return
        }
//        print("🫐 ------------")
//        print("🫐 SAVE saveContext", self.saveContext, self.saveContext.hasChanges, self.saveContext.registeredObjects, self.saveContext.insertedObjects, self.saveContext.updatedObjects, self.saveContext.deletedObjects)
//        print("🫐 SAVE mainContext", self.mainContext, self.mainContext.hasChanges, self.mainContext.registeredObjects, self.mainContext.insertedObjects, self.mainContext.updatedObjects, self.mainContext.deletedObjects)
//        print("🫐 SAVE masterContext", self.masterContext, self.masterContext.hasChanges, self.masterContext.registeredObjects, self.masterContext.insertedObjects, self.masterContext.updatedObjects, self.masterContext.deletedObjects)
//        print("🫐 ------------")
        context.perform {
            do {
                try context.save()
            } catch _ {
                if context.parent != nil {
                    self.handler(
                        for: .failure(error: .error(description: "Unable to save changes of context.")),
                        using: context,
                        with: completionHandler,
                        and: failureCompletion
                    )
                }
            }
            guard let parentContext = context.parent else { return }
            self.handler(for: .success, using: context, with: completionHandler, and: failureCompletion)
            self.save(with: parentContext, completionHandler: completionHandler, failureCompletion: failureCompletion)
        }
    }
}


extension CoreDataCoordinator: DatabaseCoordinatable {
    func getMainContext() -> NSManagedObjectContext {
        return mainContext
    }
    
    func create(weather: WeatherModel, fact: Fact, geoObject: GeoObject, forecasts: [Forecasts], partsHours: [PartsHour], hours: [Hour], completion: @escaping (Result<[NSManagedObject], DatabaseError>) -> Void) {
        self.saveContext.perform { [weak self] in
            guard let self = self else { return }
            var nsManagedObjectArray: [NSManagedObject] = []
            let factSet = NSMutableSet()
            let geoSet = NSMutableSet()
            let forecastsSet = NSMutableSet()
//Weather
            guard let weatherEntityDescription = NSEntityDescription.entity(
                forEntityName: CoreDataModelNames.WeatherDataModel.rawValue,
                in: self.saveContext
            )
                else {
                    completion(.failure(.wrongModel))
                    return
                }
            let weatherEntity = NSManagedObject(
                entity: weatherEntityDescription,
                insertInto: self.saveContext
            )
            weatherEntity.setValuesForKeys(weather.keyedValues)
            guard let weatherObject = weatherEntity as? WeatherDataModel else {
                        completion(.failure(.wrongModel))
                        return
                    }
//Fact
            guard let factEntityDescription = NSEntityDescription.entity(
                forEntityName: CoreDataModelNames.FactDataModel.rawValue,
                in: self.saveContext
            )
                else {
                    completion(.failure(.wrongModel))
                    return
                }
            let factEntity = NSManagedObject(
                entity: factEntityDescription,
                insertInto: self.saveContext
            )
            factEntity.setValuesForKeys(fact.keyedValues)
            guard let factObject = factEntity as? FactDataModel else {
                        completion(.failure(.wrongModel))
                        return
                    }
            nsManagedObjectArray.append(factObject)
            factSet.add(factObject)
//GeoObject
            guard let geoEntityDescription = NSEntityDescription.entity(
                forEntityName: CoreDataModelNames.GeoObjectDataModel.rawValue,
                in: self.saveContext
            )
                else {
                    completion(.failure(.wrongModel))
                    return
                }
            let geoEntity = NSManagedObject(
                entity: geoEntityDescription,
                insertInto: self.saveContext
            )
            geoEntity.setValuesForKeys(geoObject.keyedValues)
            guard let geoObject = geoEntity as? GeoObjectDataModel else {
                        completion(.failure(.wrongModel))
                        return
                    }
            nsManagedObjectArray.append(geoObject)
            geoSet.add(geoObject)
//Forecasts
            for forecast in forecasts { ///Начало цикл Forecasts
///Создаем описание сущности в главном контексте
                guard let forecastEntityDescription = NSEntityDescription.entity(forEntityName: CoreDataModelNames.ForecastsDataModel.rawValue, in: self.saveContext)
                    else {
                        completion(.failure(.wrongModel))
                        return
                    }
///На основе описание создаем сам объект(сущность). Это болванка на основе данного описания. То есть на основе данного типа.
                let forecastEntity = NSManagedObject(
                    entity: forecastEntityDescription,
                    insertInto: self.saveContext
                )
///Теперь мы эту пустую сущность заполняет JSONом/словарем.
                forecastEntity.setValuesForKeys(forecast.keyedValues)
                guard let  forecastObject = forecastEntity as? ForecastsDataModel else {
                            completion(.failure(.wrongModel))
                            return
                        }
                let hourSet = NSMutableSet()
//Hours
                for hour in hours {
                    if hour.date == forecast.date {
                        guard let entityDescriptionHour = NSEntityDescription.entity(forEntityName: CoreDataModelNames.HourDataModel.rawValue, in: self.saveContext)
                            else {
                                completion(.failure(.wrongModel))
                                return
                            }
                        let entityHour = NSManagedObject(
                            entity: entityDescriptionHour,
                            insertInto: self.saveContext
                        )
                        entityHour.setValuesForKeys(hour.keyedValues)
                        guard let objectHour = entityHour as? HourDataModel else {
                                    completion(.failure(.wrongModel))
                                    return
                                }
                        hourSet.add(objectHour)
                        nsManagedObjectArray.append(objectHour)
                    }
                }
//PartsHour
                for partHour in partsHours {
                    if partHour.date == forecast.date {
                        guard let entityDescriptionPartsHour = NSEntityDescription.entity(forEntityName: CoreDataModelNames.PartsHourDataModel.rawValue, in: self.saveContext)
                            else {
                                completion(.failure(.wrongModel))
                                return
                            }
                        let entityPartsHour = NSManagedObject(
                            entity: entityDescriptionPartsHour,
                            insertInto: self.saveContext
                        )
                        entityPartsHour.setValuesForKeys(partHour.keyedValues)
                        guard let objectPartsHour = entityPartsHour as? PartsHourDataModel else {
                                    completion(.failure(.wrongModel))
                                    return
                                }
                        guard objectPartsHour.source != nil else { return }
                        if objectPartsHour.source!.contains("0") {

                            let nightSet = NSMutableSet()
                            nightSet.add(objectPartsHour)
                            forecastObject.night = nightSet
                        } else {
                            let daySet = NSMutableSet()
                            daySet.add(objectPartsHour)
                            forecastObject.day = daySet
                        }
                        nsManagedObjectArray.append(objectPartsHour)
                    }
                }
                forecastObject.hours = hourSet
                forecastsSet.add(forecastObject)
                nsManagedObjectArray.append(forecastObject)
            } ///Конец цикл Forecasts

            weatherObject.fact = factSet
            weatherObject.geoObject = geoSet
            weatherObject.forecasts = forecastsSet
            nsManagedObjectArray.append(weatherObject)

///Проверяем есть ли в нашем контексте какие-либо изменения, и если есть, сохраняем.
            guard self.saveContext.hasChanges else {
                completion(.failure(.store(model: String(describing: nsManagedObjectArray))))
                return
            }

            self.save(with: self.saveContext,
                      completionHandler: {
                completion(.success(nsManagedObjectArray))
            },
                      failureCompletion: { error in
                completion(.failure(error))
            })
        }
    }

    func fetch(_ model: NSManagedObject.Type, predicate: NSPredicate?, completion: @escaping (Result<[NSManagedObject], DatabaseError>) -> Void) {
        self.saveContext.perform {
            let request = model.fetchRequest()
            request.predicate = predicate
            guard
                let fetchRequestResult = try? self.saveContext.fetch(request),
                let fetchedObjects = fetchRequestResult as? [NSManagedObject]
            else {
                self.mainContext.perform {
                    completion(.failure(.wrongModel))
                }
                return
            }
//            print("🫐 ------------")
//            print("🫐 FETCH saveContext", self.saveContext, self.saveContext.hasChanges, self.saveContext.registeredObjects, self.saveContext.insertedObjects, self.saveContext.updatedObjects, self.saveContext.deletedObjects)
//            print("🫐 FETCH mainContext", self.mainContext, self.mainContext.hasChanges, self.mainContext.registeredObjects, self.mainContext.insertedObjects, self.mainContext.updatedObjects, self.mainContext.deletedObjects)
//            print("🫐 FETCH masterContext", self.masterContext, self.masterContext.hasChanges, self.masterContext.registeredObjects, self.masterContext.insertedObjects, self.masterContext.updatedObjects, self.masterContext.deletedObjects)
//            print("🫐 ------------")
            self.mainContext.perform {
                completion(.success(fetchedObjects))
            }
        }
    }

    func fetchAll(_ model: NSManagedObject.Type, completion: @escaping (Result<[NSManagedObject], DatabaseError>) -> Void) {
        self.fetch(model, predicate: nil, completion: completion)
    }

    func delete(_ model: NSManagedObject.Type, predicate: NSPredicate?, completion: @escaping (Result<[NSManagedObject], DatabaseError>) -> Void) {
        self.fetch(model, predicate: predicate) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let fetchedObjects):
                guard !fetchedObjects.isEmpty else {
                    completion(.failure(.wrongModel))
                    return
                }
                self.saveContext.perform {
                    fetchedObjects.forEach { fetchedObject in
                        self.saveContext.delete(fetchedObject)
                    }
                    self.save(with: self.saveContext,
                              completionHandler: {
                        completion(.success(fetchedObjects))
                    },
                              failureCompletion: { error in
                        completion(.failure(error))
                    })
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func deleteAll(_ model: NSManagedObject.Type, completion: @escaping (Result<[NSManagedObject], DatabaseError>) -> Void) {
        self.delete(model, predicate: nil, completion: completion)
    }
}
