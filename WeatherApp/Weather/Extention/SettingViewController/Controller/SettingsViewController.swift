//
//  SettingsViewController.swift
//  Weather
//
//  Created by Дмитрий Никоноров on 30.08.2022.
//

import UIKit

final class SettingsViewController: UIViewController {
    //MARK: - Properties
    private let model: SettingModel
    private let menuDelegate: MenuDelegate
    private let mainScreenDelegate: MainScreenDelegate
    private lazy var settingView: SettingView = {
        let settingView = SettingView()
        settingView.toAutoLayout()
        return settingView
    }()
    //MARK: - Methods
    ///Настройка нав бара
    private func setupNavigationController() {
        navigationController?.navigationBar.isHidden = true
    }
    ///Настройка UI
    private func setupUI() {
        view.addSubviews(settingView)
    }
    ///Настройка views
    private func setupView() {
        settingView.setup(withModel: model.viewModel)
        settingView.setupButtonAction = {
            self.hideSettings()
        }

        settingView.tempSegmentAction = { [weak self] index in
            guard let self = self else { return }
            self.tempDidChanged(index: index)
        }

        settingView.windSpeedSegmentAction = { [weak self] index in
            guard let self = self else { return }
            ///Действие при изменении формата скорости
            self.windSpeedDidChanged(index: index)
        }

        settingView.timeFormatSegmentAction = { [weak self] index in
            guard let self = self else { return }
            ///Действие при изменении формата времени
            self.timeFormatDidChanged(index: index)
        }

        settingView.notificationSegmentAction = { [weak self] index in
            guard let self = self else { return }
            self.notificationDidChanged(index: index)
        }
    }
    ///Настройка констрейнтов
    private func setupConstraints() {
        [
            settingView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            settingView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            settingView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            settingView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ].forEach { $0.isActive = true }
    }

    ///Установить сегментед контроллы на  выбранные позиции
    private func setupDataOnView() {
        let temp = Defaults.tempCalculationSystem
        settingView.setupTemp(temp.rawValue)

        let windSpeed = Defaults.windSpeedSystem
        settingView.setupWindSpeed(windSpeed.rawValue)

        let timeFormat = Defaults.timeFormat
        settingView.setupTimeFormat(timeFormat.rawValue)

        settingView.setupNotification(2)
    }
    ///Скрыть настройки
    private func hideSettings() {
        dismiss(animated: true)
        menuDelegate.setSettings()
        mainScreenDelegate.updateDataOnMainScreen()
        mainScreenDelegate.hideMenu()
    }
    ///Действие при изменении формата температуры
    private func tempDidChanged(index: Int) {
        switch index {
        case 0:
            Defaults.tempCalculationSystem = .celsius
        case 1:
            Defaults.tempCalculationSystem = .fahrenheit
        default:
            break
        }
    }
    ///Действие при изменении формата скорости
    private func windSpeedDidChanged(index: Int) {
        switch index {
        case 0:
            Defaults.windSpeedSystem = .metersPerSecond
        case 1:
            Defaults.windSpeedSystem = .yardPerSecond
        default:
            break
        }
    }
    ///Действие при изменении формата времени
    private func timeFormatDidChanged(index: Int) {
        switch index {
        case 0:
            Defaults.timeFormat = ._24h
        case 1:
            Defaults.timeFormat = ._12h
        default:
            break
        }
    }
    private func notificationDidChanged(index: Int) {
    }
    //MARK: - Init
    init(
        model: SettingModel,
        menuDelegate: MenuDelegate,
        mainScreenDelegate: MainScreenDelegate
    ) {
        self.model = model
        self.menuDelegate = menuDelegate
        self.mainScreenDelegate = mainScreenDelegate
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Lifecyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        setupView()
        setupUI()
        setupConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupDataOnView()
    }
}
