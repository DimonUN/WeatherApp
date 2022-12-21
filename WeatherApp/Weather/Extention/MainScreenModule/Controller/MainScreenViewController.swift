//
//  MainScreenViewController.swift
//  Weather
//
//  Created by Дмитрий Никоноров on 30.08.2022.
//

import UIKit
import CoreData

protocol MainScreenDelegate {
    ///Скрыть меню
    func hideMenu()
    ///Обновить данные на главном экране
    func updateDataOnMainScreen()
    ///Изменить локацию
    func changeLocation()
    ///Сбросить текущий прогноз
    func resetForcast()
}

final class MainScreenViewController: UIViewController {
    //MARK: - Network
    private var networkService = NetworkService()
    private let databaseCoordinator: DatabaseCoordinatable
    private let state: GeolocationState
    lazy var maincontext = databaseCoordinator.getMainContext()
    ///Констрейнты для menuView
    var menuLeading: NSLayoutConstraint?
    var menuTrailing: NSLayoutConstraint?
    var menuTop: NSLayoutConstraint?
    var menuBottom: NSLayoutConstraint?
    var menuNewTrailing: NSLayoutConstraint?

    ///Links for API
    private enum Links {
        static let geocoding = "https://geocode-maps.yandex.ru/1.x/?apikey=cdcfb4b2-4d81-448a-8025-66794dacf3ff&format=json&geocode="
        static let forcastScheme = "https"
        static let forcastHost = "api.weather.yandex.ru"
        static let forcastPath = "/v2/forecast"
    }
    ///Получить прогноз для локации
    private func getForecast(for location: String) {
        getCoordinates(forLocation: location)
    }
    ///Получение координат по названию
    private func getCoordinates(forLocation location: String) {
        let address = location
        guard let url = URL(string: Links.geocoding + address.encodeUrl) else { return }
        networkService.request(url: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                do {
                    let geocodingModel = try JSONDecoder().decode(GeocodingModel.self, from: data)
                    guard let additionalLocation = self.additionalLocation else { return }
                    ///Проверка получили ли мы координаты по введенному городу
                    if geocodingModel.response.geoObjectCollection.featureMember.count == 0 {
                        ///Если нет, то показываем ошибку
                        let alertController = UIAlertController(
                            title: self.model.controllerModel.alertFindTitle,
                            message:
                                self.model.controllerModel.alertFindMessageStart +
                                " " +
                                additionalLocation +
                                " " +
                                self.model.controllerModel.alertFindMessageEnd,
                            preferredStyle: .alert
                        )
                        let addAction = UIAlertAction(
                            title: self.model.controllerModel.alertFindActionTitle,
                            style: .default
                        ) { _ in
                            self.showAddLocationAlert()
                        }
                        let cancelAction = UIAlertAction(
                            title: self.model.controllerModel.alertFindCanceltitle,
                            style: .cancel
                        ) { _ in
                            self.dismiss(animated: true)
                        }
                        alertController.addAction(addAction)
                        alertController.addAction(cancelAction)
                        self.present(alertController, animated: true)
                    } else {
                        ///Если да, то делаем запрос по координатам
                        let coordinate =  geocodingModel.response.geoObjectCollection.featureMember[0].geoObject.point.pos
                        let coordinateArray = coordinate.components(separatedBy: " ")
                        let lon = coordinateArray[0]
                        let lat = coordinateArray[1]
                        self.getForcastFromCoordinates(lat: lat, lon: lon)
                    }
                } catch let error {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    ///Получить прогноз по координатам
    private func getForcastFromCoordinates(lat: String, lon: String) {
        var urlComponents = URLComponents()
        urlComponents.scheme = Links.forcastScheme
        urlComponents.host = Links.forcastHost
        urlComponents.path = Links.forcastPath
        urlComponents.queryItems = [
            URLQueryItem(name: NetworkComponents.lat, value: lat),
            URLQueryItem(name: NetworkComponents.lon, value: lon),
            URLQueryItem(name: NetworkComponents.extra, value: NetworkComponents.extraValue)
            ]
        guard let url = urlComponents.url else {
            print("URL error")
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = NetworkComponents.getMethod
        let headers = [
            "X-Yandex-API-Key": "226e449a-0102-4186-afa7-484ac101a8f6"
        ]
        urlRequest.allHTTPHeaderFields = headers
        networkService.request(url: urlRequest) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                do {
                    let weatherModel = try JSONDecoder().decode(WeatherModel.self, from: data)
                    self.prepareDataAndUploadInCoreData(with: weatherModel)
                    self.mainScreenView.setupView(forEmptyScreen: false)
                } catch let error {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    //Подготовка данных для загрузки в CoreData
    private func prepareDataAndUploadInCoreData(with model: WeatherModel) {
        let weather = model
        let fact = model.fact
        let geo = model.geoObjectFromForcast
        var forecastsArray: [Forecasts] = []
        var partsHourArray: [PartsHour] = []
        var hoursArray: [Hour] = []
        ///Массив для сохранения Не опциональных Forecasts
        var notNilforecasts: [Forecasts] = []
        ///Перебор всех значений model.forecasts для безопасного unwrap'a
        model.forecasts.forEach({
            if let forecast = $0 {
                notNilforecasts.append(forecast)
            }
        })
        ///Перебор всех forecasts для заполнения данными hoursArray, partsHourArray, forecastsArray
        for forecast in notNilforecasts {
            ///Каждому hour, который относится к текущему forecast, запиывает дату в свойство date
            for hour in forecast.hours {
                var newHour = hour
                newHour.date = forecast.date
                hoursArray.append(newHour)
            }
            ///Тоже самое для dayParts и nightParts
            var dayParts = forecast.parts.day
            dayParts.date = forecast.date
            partsHourArray.append(dayParts)

            var nightParts = forecast.parts.night
            nightParts.date = forecast.date
            partsHourArray.append(nightParts)
            forecastsArray.append(forecast)
        }
        ///Очищаем данные по прогнозу в CoreData
        databaseCoordinator.deleteAll(WeatherDataModel.self) {
            result in
            switch result {
            case .success(_):
                debugPrint("deleteAll success")
            case .failure(let error):
                debugPrint(error)
            }
        }
        ///Сохраняем новый прогноз в CoreData используя сохданные модели
        databaseCoordinator.create(
            weather: weather,
            fact: fact,
            geoObject: geo,
            forecasts: forecastsArray,
            partsHours: partsHourArray,
            hours: hoursArray
        ) {
            result in
            switch result {
            case .success(let objects):
                for object in objects {
                    if object is WeatherDataModel {
                        self.transferFromDatabaseToView()
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    //MARK: - Properties
    ///Модель модуля MainScreenModule
    private var model: MainScreenModel
    private lazy var titleWithoutGeolocation = model.controllerModel.titleWithoutGeolocation

    //TODO: - Сделать получение геолокации пользователя
    ///Переменная для имитации текущей локации пользователя из данных системы
    private lazy var geolocation = "Москва"

    ///Переменная с локацией, добавленно вручную. Хранится в Defaults
    private var additionalLocation: String? {
        didSet {
            Defaults.userlLocation = additionalLocation
        }
    }
    private var interpritator: Interpritatable
    ///Массив с моделями прогноза на три часа
    private var threeHourForcastArray: [ThreeHourForcast] = []
    ///Массив с моделями прогноза на один день
    private var oneDayForcastArray: [OneDayForcastModel] = []
    ///View с боковым меню
    private lazy var menu = MenuView(
        mainScreenDelegate: self,
        navigationController: self.navigationController ?? nil
    )
    ///Состояние бокового меню
    enum MenuState {
        case opened
        case closed
    }
    private var menuState: MenuState = .closed
    ///View модуля MainScreenModule
    private lazy var mainScreenView: MainScreenView = {
        let mainScreenView = MainScreenView()
        mainScreenView.toAutoLayout()
        return mainScreenView
    }()
    ///Количество секций
    private enum NumberOfSectionsIn {
        static let tableView = 2
        static let collectionView = 1
    }
    ///Количество ячеек в секциях таблицы
    private enum NumberOfRowsIn {
        static let zeroSectionTableView = 1
        static let firstSectionTableView = 25
        static let defaultSectionTableView = 0
    }
    ///Количество ячеек в секции коллекции
    private enum NumberOfItemIn {
        static let zeroSectionCollectionView: Int = 8
    }
    ///Константные велечины для коллекции
    private enum ConstantsForCollection {
        static let itemHeight: CGFloat = 92.0
        static let itemWidth: CGFloat = 48.0

        static let leftInsets: CGFloat = 16.0
        static let rightInsets: CGFloat = 16.0
        static let topInsets: CGFloat = 10
        static let bottomInsets: CGFloat = 10

        static let minimumLineSpacing: CGFloat = 16.0
    }
    //MARK: - Methods
    ///Выгрузка данных из БД в UI
    private func transferFromDatabaseToView() {
        databaseCoordinator.fetchAll(WeatherDataModel.self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let dataModels):
                ///Получение массива weatherDataModel
                guard let weatherDataModelArray = dataModels as? [WeatherDataModel] else { return }
                ///Создаем массив weatherModelArray
                let weatherModelArray = weatherDataModelArray.map {
                    WeatherModel(weatherDataModel: $0)
                }
                guard let weatherModel = weatherModelArray[0] else { return }
                ///Cтрана
                let country = weatherModel.geoObjectFromForcast.country.name
                ///Город
                let locality = weatherModel.geoObjectFromForcast.locality.name

                let location = (locality ?? "") + ", " + (country ?? "")
                self.additionalLocation = locality
                self.navigationItem.title = location
                Defaults.userlLocation = location

                //MARK: - Header
                ///Прогноз
                let condition = self.interpritator.conditionInterpritator(
                    condition: weatherModel.fact.condition
                )
                ///Система измерения температуры
                let tempSystem = Defaults.tempCalculationSystem
                ///Система измерения скорости ветра
                let windSpeedSystem = Defaults.windSpeedSystem
                ///Скорость ветра
                let windSpeed = self.interpritator.convertSpeed(
                    speed: weatherModel.fact.windSpeed,
                    to: windSpeedSystem
                )
                ///УФ-индекс
                let uvIndex = weatherModel.fact.uvIndex
                ///Влажность
                let humidity = weatherModel.fact.humidity
                ///Время сервера в UTC
                let time = weatherModel.nowDt

                ///Форматирование даты с сервера
                let format = Defaults.timeFormat
                let newDate = self.interpritator.formattingFromISO8601(date: time, with: format)
                ///Массив прогнозов на 7 дней
                var newForecasts: [Forecasts] = []
                ///Делаем перебор, проверяем на nil
                weatherModel.forecasts.forEach({
                    if let forecast = $0 {
                        newForecasts.append(forecast)
                    }
                })
                ///Сортируем от меньшей даты до большей
                let sortedForecasts = newForecasts.sorted(by: {$0.date < $1.date})
                ///Прогноз по сегодняшней дате
                let todayForecast = sortedForecasts[0]
                ///Восход
                let sunrise = todayForecast.sunrise
                ///Закат
                let sunset = todayForecast.sunset
                ///Текущая температура
                let temp = self.interpritator.convertTemperature(
                    temperature: weatherModel.fact.temp,
                    to: tempSystem
                )
                ///Температура минимальная
                let tempMin = self.interpritator.convertTemperature(
                    temperature: todayForecast.parts.night.tempMin ?? 0,
                    to: tempSystem
                )
                ///Температура максимальная
                let tempMax = self.interpritator.convertTemperature(
                    temperature: todayForecast.parts.day.tempMax ?? 0,
                    to: tempSystem
                )
                ///Модель данных для хэдера таблицы
                let headerModel = HeaderForcastModel(
                    currentForcast: condition,
                    currentTemperature: String(temp),
                    temperatureRangeFrom: String(tempMin),
                    temperatureRangeTo: String(tempMax),
                    timeOfSunrise: String(sunrise),
                    timeOfSunset: String(sunset),
                    uvIndex: String(uvIndex),
                    wind: String(windSpeed),
                    humidity: String(humidity),
                    currentDate: newDate
                )

                //MARK: - ThreeHourForcastTableViewCell
                ///Создание массава моделей для ThreeHourForcastTableViewCell
                var threeHourForecastArray: [ThreeHourForcast] = []
                todayForecast.hours.forEach({
                    let temp = self.interpritator.convertTemperature(
                        temperature: $0.temp ?? 0,
                        to: tempSystem
                    )
                    let threeHourForecast = ThreeHourForcast(
                        hour: $0.hour ?? "",
                        temp: temp,
                        condition: $0.condition
                    )
                    threeHourForecastArray.append(threeHourForecast)
                })
                let sortedFromSmallestToLargestArray = threeHourForecastArray.sorted(
                    by: { $0.hour < $1.hour }
                )
                var threeHourArray: [ThreeHourForcast] = []
                sortedFromSmallestToLargestArray.forEach({
                    guard let hour = Int($0.hour) else { return }
                    if hour % 3 == 0 {
                        threeHourArray.append($0)
                    } else if hour == 0 {
                        threeHourArray.append($0)
                    }
                })
                let finalSortedArray = threeHourArray.sorted(by: {
                    if let hour1 = Int($0.hour), let hour2 = Int($1.hour) {
                        return hour1 < hour2
                    } else {
                        return false
                    }
                })
                ///Присвоение значений массиву, который используется DataSource Коллекции
                self.threeHourForcastArray = finalSortedArray
                self.mainScreenView.callToTableView()

                //MARK: - OneDayForcastModel
                var oneDayForcastModelArray: [OneDayForcastModel] = []
                sortedForecasts.forEach({
                    let tomorrowForecast = $0
                    let dayPrecStrength = self.interpritator.precStrengthInterpritator(
                        strength: todayForecast.parts.day.precStrength,
                        withType: todayForecast.parts.day.precType
                    )
                    let nightPrecStrength = self.interpritator.precStrengthInterpritator(
                        strength: todayForecast.parts.night.precStrength,
                        withType: todayForecast.parts.night.precType
                    )
                    let dayCloudness = self.interpritator.cloudnessInterpritator(
                        cloudness: todayForecast.parts.day.cloudness
                    )
                    let nightCloudness = self.interpritator.cloudnessInterpritator(
                        cloudness: todayForecast.parts.night.cloudness
                    )
                    let dayWindDir = self.interpritator.windDirectionInterpritator(
                        windDir: todayForecast.parts.day.windDir
                    )
                    let nightWindDir = self.interpritator.windDirectionInterpritator(
                        windDir: todayForecast.parts.night.windDir
                    )
                    let moonCode = self.interpritator.moonCodeInterpritator(
                        moonCode: todayForecast.moonCode
                    )
                    let dayCondition = self.interpritator.conditionInterpritator(
                        condition: todayForecast.parts.day.condition
                    )
                    let nightCondition = self.interpritator.conditionInterpritator(
                        condition: todayForecast.parts.night.condition
                    )
                    let newDate = self.interpritator.dateInterpritatorForOneDayForcast(
                        dateFromDataBaseModel: tomorrowForecast.date
                    )
                    let image = self.interpritator.imageInterpritator(condition: todayForecast.parts.day.condition)
                    let tempMin = self.interpritator.convertTemperature(
                        temperature: todayForecast.parts.night.tempMin ?? 0,
                        to: tempSystem
                    )
                    let tempMax = self.interpritator.convertTemperature(
                        temperature: todayForecast.parts.day.tempMax ?? 0,
                        to: tempSystem
                    )
                    let dayTemp = self.interpritator.convertTemperature(
                        temperature: todayForecast.parts.day.tempAvg ?? 0,
                        to: tempSystem
                    )
                    let dayFeelsLike = self.interpritator.convertTemperature(
                        temperature: todayForecast.parts.day.feelsLike ,
                        to: tempSystem
                    )
                    let nightTemp = self.interpritator.convertTemperature(
                        temperature: todayForecast.parts.night.tempAvg ?? 0,
                        to: tempSystem
                    )
                    let nightFeelsLike = self.interpritator.convertTemperature(
                        temperature: todayForecast.parts.day.feelsLike ,
                        to: tempSystem
                    )
                    let dayWindSpeed = self.interpritator.convertSpeed(speed: todayForecast.parts.day.windSpeed, to: Defaults.windSpeedSystem)
                    let nightWindSpeed = self.interpritator.convertSpeed(speed: todayForecast.parts.night.windSpeed, to: Defaults.windSpeedSystem)
                    ///Создание модели прогноза на сутки
                    let dayForcastModel = OneDayForcastModel(
                        date: newDate,
                        condition: dayCondition,
                        humidity: tomorrowForecast.parts.night.humidity,
                        tempMin: tempMin,
                        tempMax: tempMax,
                        image: image,

                        dayCondition: dayCondition,
                        dayTemp: dayTemp,
                        dayFeelsLike: dayFeelsLike,
                        dayWindSpeed: dayWindSpeed,
                        dayWindDirection: dayWindDir,
                        dayUVIndex: todayForecast.parts.day.uvIndex,
                        dayPrecStrength: dayPrecStrength,
                        dayCloudness: dayCloudness,

                        nightCondition: nightCondition,
                        nightTemp: nightTemp,
                        nightFeelsLike: nightFeelsLike,
                        nightWindSpeed: nightWindSpeed,
                        nightWindDirection: nightWindDir,
                        nightUVIndex: todayForecast.parts.night.uvIndex,
                        nightPrecStrength: nightPrecStrength,
                        nightCloudness: nightCloudness,

                        moonCode: moonCode,
                        sunrise: todayForecast.sunrise,
                        sunset: todayForecast.sunset
                    )
                    oneDayForcastModelArray.append(dayForcastModel)
                })
                ///Убираем из массива первый элемент - прогноз на сегодня
                oneDayForcastModelArray.removeFirst()

                self.oneDayForcastArray = oneDayForcastModelArray
                self.mainScreenView.loadDataInHeader(self.model.headerModel)
                self.mainScreenView.loadForcastInHeader(headerModel)
                self.mainScreenView.callToTableViewReload()
                print(dataModels.count)
            case .failure(let error):
                print(error)
            }
        }
    }
    ///Настройка нав бара
    private func setupNavigationBar() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = false
        let backButton = UIBarButtonItem()
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: model.controllerModel.rightBarButtonImage,
            style: .plain,
            target: self,
            action: #selector(geoDidTapped)
        )
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: model.controllerModel.leftBarButtonImage,
            style: .plain,
            target: self,
            action: #selector(burgerDidTapped)
        )
        navigationItem.rightBarButtonItem?.tintColor = model.controllerModel.rightBarButtonTintColor
        navigationItem.leftBarButtonItem?.tintColor = model.controllerModel.leftBarButtonItemTintColor
    }
    ///Настройка mainScreenView
    private func setupMainScreenView() {
        view.addSubviews(mainScreenView)
        mainScreenView.setup(withModel: model.viewModel)
        mainScreenView.setupTableView(dataSource: self, delegate: self)
    }
    private func setupConstraints() {
        [
            mainScreenView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainScreenView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainScreenView.topAnchor.constraint(equalTo: view.topAnchor),
            mainScreenView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ].forEach { $0.isActive = true }
    }
    ///Создание бокового меню
    private func createMenu() {
        menu.frame = CGRect(
            x: 0 - view.frame.width,
            y: 0, width: view.frame.width,
            height: view.frame.height
        )
        view.addSubview(menu)
        menu.setup(withModel: model.menuUIModel)

    }
    ///Показать/скрыть боковое меню
    private func showHideMenu() {
        switch menuState {
        case .closed:
            UIView.animate(
                withDuration: 0.4,
                delay: 0,
                options: .curveEaseInOut,
                animations: { [weak self] in
                    guard let self = self else { return }
                    self.menu.frame = CGRect(
                        x: 0,
                        y: 0,
                        width: self.view.frame.width,
                        height: self.view.frame.height
                    )
                    ///Включить заливку экрана серым, когда открывается меню
                    self.mainScreenView.changeFilling()
                }
            )
            menuState = .opened
        case .opened:
            UIView.animate(
                withDuration: 0.4,
                delay: 0,
                options: .curveEaseInOut,
                animations: { [weak self] in
                    guard let self = self else { return }
                    self.menu.frame = CGRect(
                        x: 0 - self.view.frame.width,
                        y: 0,
                        width: self.view.frame.width,
                        height: self.view.frame.height
                    )
                    ///Включить заливку экрана серым, когда открывается меню
                    self.mainScreenView.changeFilling()
                }
            )
            menuState = .closed
        }
    }
    //MARK: -Objc methods
    ///Действие по нажатию на бургет-меню
    @objc private func burgerDidTapped(_ sender: UIBarButtonItem) {
        menu.setLocation(additionalLocation ?? "")
        showHideMenu()
    }
    ///Действие по нажатию на иконку геолокации
    @objc private func geoDidTapped(_ sender: UIBarButtonItem) {
        showAddLocationAlert()
    }
    ///Показать алерт с текстовым полем для ввода города
    private func showAddLocationAlert() {
        let alertController = UIAlertController(
            title: model.controllerModel.alertAddCityTitle,
            message: nil,
            preferredStyle: .alert
        )
        alertController.addTextField() { [weak self] textField in
            guard let self = self else { return }
            textField.placeholder = self.model.controllerModel.alertAddCityPlaceholder
        }
        let addAction = UIAlertAction(
            title: model.controllerModel.alertAddCityActionTitle,
            style: .default
        ) { _ in
            let field = alertController.textFields?[0]
            guard
                let text = field?.text,
                    text.count > 0
            else { return }
            self.getCoordinates(forLocation: text)
            self.additionalLocation = text
        }
        let cancelAction = UIAlertAction(
            title: model.controllerModel.alertAddCityCancelTitle,
            style: .cancel
        ) { [weak self] _ in
            guard let self = self else { return }
            self.dismiss(animated: true)
        }
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    //MARK: - Lifecyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        ///Логика настройки вью в зависимости от того,
        ///дал ли пользователь разрешение на использование геолокации
        switch state {
        case .geolocationAllowed:
            navigationItem.title = geolocation
            getForecast(for: geolocation)
            view.backgroundColor = model.controllerModel.viewBackgroundColor
            setupMainScreenView()
            setupConstraints()
        case .geolocationNotAllowed:
            let location = Defaults.userlLocation
            if let location = location {
                navigationItem.title = location
                self.getCoordinates(forLocation: location)
            } else {
                navigationItem.title = titleWithoutGeolocation
            }
            setupMainScreenView()
            setupConstraints()
        }
        setupNavigationBar()
        createMenu()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    //MARK: - Init
    init(model: MainScreenModel,
         state: GeolocationState,
         databaseCoordinator: DatabaseCoordinatable,
         interpritator: Interpritatable
    ) {
        additionalLocation = Defaults.userlLocation
        self.model = model
        self.state = state
        self.databaseCoordinator = databaseCoordinator
        self.interpritator = interpritator
        super.init(nibName: nil, bundle: nil)
        setupMainView()
    }
    ///Настраиваени mainView в соответствии с выбранными настройками локации
    private func setupMainView() {
        if state == .geolocationAllowed {
            mainScreenView.setupView(forEmptyScreen: false)
            additionalLocation = geolocation
        } else if state == .geolocationNotAllowed, additionalLocation == nil {
            mainScreenView.setupView(forEmptyScreen: true)
        } else if state == .geolocationNotAllowed, additionalLocation != nil {
            mainScreenView.setupView(forEmptyScreen: true)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: - Ext TableViewDataSource
extension MainScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return NumberOfRowsIn.zeroSectionTableView
        case 1:
            return oneDayForcastArray.count
        default:
            return NumberOfRowsIn.defaultSectionTableView
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = ThreeHourForcastTableViewCell(style: .default, reuseIdentifier: TableReuseIdentifiers.threeHourForcast.rawValue)
            cell.selectionStyle = .none
            cell.setup(dataSource: self, delegate: self)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: TableReuseIdentifiers.oneDayForcast.rawValue,
                for: indexPath
            ) as! OneDayForcastTableViewCell
            cell.selectionStyle = .none
            let data = oneDayForcastArray[indexPath.row]
            cell.setupCell(withModel: model.oneDayForcastTableCellModel)
            cell.setupForcast(
                date: data.date ?? "",
                humidity: String(data.humidity ?? 0) + "%",
                mainForcast: data.condition ?? "",
                temperatureFrom: data.tempMin ?? "",
                temperatureTo: data.tempMax ?? "",
                image: data.image
            )
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: TableReuseIdentifiers.defaultCell.rawValue, for: indexPath)
            return cell
        }
    }
}
//MARK: - Ext TableViewDelegate
extension MainScreenViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return NumberOfSectionsIn.tableView
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = oneDayForcastArray[indexPath.row]
        var dateArray: [String] = []
        oneDayForcastArray.forEach({
            dateArray.append($0.date ?? "")
        })
        var dailyForcastModel = DailyForcastModel()
        dailyForcastModel.location = additionalLocation
        dailyForcastModel.oneDayForcastModel = model
        let dailyForecastViewController = DailyForecastViewController(
            model: dailyForcastModel,
            index: indexPath.row,
            interpritator: interpritator,
            dates: dateArray
        )
        navigationController?.pushViewController(dailyForecastViewController, animated: true)
    }
}
//MARK: - Ext CollectionViewDataSource
extension MainScreenViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        threeHourForcastArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CollectionReuseIdentifiers.threeHourForcat.rawValue,
            for: indexPath
        ) as! ThreeHourForcastCollectionViewCell
        let data = threeHourForcastArray[indexPath.row]
        let newTime = interpritator.timeInterpritator(time: data.hour)
        let image = interpritator.imageInterpritator(condition: data.condition)
        
        cell.setupCell(withModel: model.threeHourCollectionCellModel)
        cell.setupForcast(time: newTime, weatherImage: image, temperature: String(data.temp))
        return cell
    }
}
//MARK: - Ext CollectionViewDelegateFlowLayout
extension MainScreenViewController: UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return NumberOfSectionsIn.collectionView
    }
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: ConstantsForCollection.itemWidth, height: ConstantsForCollection.itemHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(
            top: ConstantsForCollection.topInsets,
            left: ConstantsForCollection.leftInsets,
            bottom: ConstantsForCollection.bottomInsets,
            right: ConstantsForCollection.rightInsets
        )
    }
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return ConstantsForCollection.minimumLineSpacing
    }
}
//MARK: - Ext MainScreenDelegate
extension MainScreenViewController: MainScreenDelegate {
    func resetForcast() {
        getForecast(for: geolocation)
        showHideMenu()
    }
    func changeLocation() {
        let onboardingModel = OnboardingModel()
        let onboardingViewController = OnboardingViewController(
            model: onboardingModel,
            openFrom: .mainScreen,
            mainScreenDelegate: self
        )
        let navController = UINavigationController(rootViewController: onboardingViewController)
        navController.modalPresentationStyle = .fullScreen
        navigationController?.present(navController, animated: true)
    }
    func hideMenu() {
        showHideMenu()
    }
    func updateDataOnMainScreen() {
        transferFromDatabaseToView()
    }
}
