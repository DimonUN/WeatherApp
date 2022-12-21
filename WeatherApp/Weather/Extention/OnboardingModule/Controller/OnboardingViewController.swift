//
//  OnboardingViewController.swift
//  Weather
//
//  Created by Дмитрий Никоноров on 30.08.2022.
//

import UIKit

final class OnboardingViewController: UIViewController {
    //MARK: - Properties
    ///Модель с данными для модуля
    private let model: OnboardingModel
    ///Откуда открыт модуль - из sceneDelegate / mainScreen
    enum OpenFrom {
        case delegate
        case mainScreen
    }
    private var openFrom: OpenFrom
    private var mainScreenDelegate: MainScreenDelegate?
    ///View модуля
    private lazy var onboardingView: OnboardingView = {
        let onboardingView = OnboardingView()
        onboardingView.toAutoLayout()
        return onboardingView
    }()

//MARK: - Methods
    ///Настройка констрейнтов
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            onboardingView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor)
            ,
            onboardingView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor
            ),
            onboardingView.topAnchor.constraint(
                equalTo: view.topAnchor
            ),
            onboardingView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor
            ),
        ])
    }
    ///Локига, прогружаемая в замыкания accessIsAllowed && accessNotAllowed внутри onboardingView
    private func actionForModuleOpenFrom(
        _ openFrom: OpenFrom,
        andAccessIsAllowed accessIsAllowed: Bool
    ) {
        ///Проверка, откуда был открыт OnboardingModule
        switch openFrom {
        ///Из SceneDelegate
        case .delegate:
            Defaults.geolocationState = accessIsAllowed ? .geolocationAllowed : .geolocationNotAllowed
            Defaults.isRequestShow = true
            guard let databaseCoord =
                    try? CoreDataCoordinator(
                        nameOfDataModelResource: "Database",
                        withExtension: .momd
                    ) else { return }
            let interpritator = Interpritator()
            let model = MainScreenModel()
            let mainScreenController = MainScreenViewController(
                model: model,
                state: accessIsAllowed ? .geolocationAllowed : .geolocationNotAllowed,
                databaseCoordinator: databaseCoord,
                interpritator: interpritator
            )
            self.navigationController?.pushViewController(
                mainScreenController,
                animated: true
            )
        ///Из mainScreen
        case .mainScreen:
            if accessIsAllowed {
                Defaults.geolocationState = .geolocationAllowed
                self.navigationController?.dismiss(animated: true)
                self.mainScreenDelegate?.resetForcast()
            } else {
                Defaults.geolocationState = .geolocationNotAllowed
                self.navigationController?.dismiss(animated: true)
            }
        }
    }
    ///Настройка view
    private func setupView() {
        view.addSubviews(onboardingView)
        ///Настройка onboardingView данными из модели
        let model = model.viewModel
        onboardingView.setup(withModel: model)
        ///Настройка замыкания, которое вызывается если пользователь дал доступ
        onboardingView.accessIsAllowed = { [weak self] in
            guard let self = self else { return }
            self.actionForModuleOpenFrom(self.openFrom, andAccessIsAllowed: true)
        }
        ///Настройка замыкания, которое вызывается если пользователь не дал доступ
        onboardingView.accessNotAllowed = { [weak self] in
            guard let self = self else { return }
            self.actionForModuleOpenFrom(self.openFrom, andAccessIsAllowed: false)
        }
    }
    //MARK: - Lifecyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }

//MARK: - Init
    init(model: OnboardingModel, openFrom: OpenFrom, mainScreenDelegate: MainScreenDelegate?) {
        self.openFrom = openFrom
        self.model = model
        self.mainScreenDelegate = mainScreenDelegate
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
