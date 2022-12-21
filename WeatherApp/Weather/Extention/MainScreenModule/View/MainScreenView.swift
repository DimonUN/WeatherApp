//
//  MainScreenView.swift
//  Weather
//
//  Created by Дмитрий Никоноров on 12.09.2022.
//

import UIKit

final class MainScreenView: UIView {
    //MARK: - Ptoperties
    private lazy var fillView: UIView = {
        let fillView = UIView()
        fillView.alpha = 0
        fillView.toAutoLayout()
        return fillView
    }()
    ///Декоративное view в нижней части экрана
    private lazy var bottomView: UIView = {
        let bottomView = UIView()
        bottomView.toAutoLayout()
        return bottomView
    }()
    ///Header таблицы
    private lazy var headerView: HeaderView = {
        let headerView = HeaderView()
        headerView.alpha = 0
        return headerView
    }()
    ///Таблица
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.toAutoLayout()
        return tableView
    }()
    //MARK: - Methods
    ///Настройка UI для пустого экрана
    private func emptyScreenSetupUI() {
        addSubviews(bottomView)
    }
    ///Настройка констрейнтов для пустого экрана
    private func emptyScreenSetupConstraints() {
        [
            bottomView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 44.0)
        ].forEach { $0.isActive = true }
    }
    ///Настройка UI для не пустого экрана
    private func setupUI() {
        addSubviews(tableView, fillView, bottomView)
    }
    ///Настройка констрейнтов для не пустого экрана
    private func setupConstraints() {
        [
            fillView.leadingAnchor.constraint(equalTo: leadingAnchor),
            fillView.trailingAnchor.constraint(equalTo: trailingAnchor),
            fillView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            fillView.bottomAnchor.constraint(equalTo: bottomAnchor),

            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16.0),

            bottomView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 44.0)
        ].forEach { $0.isActive = true }
    }
    ///Настройка tableView
    private func setupTableView() {
        tableView.tableHeaderView = headerView
        tableView.register(
            ThreeHourForcastTableViewCell.self,
            forCellReuseIdentifier: TableReuseIdentifiers.threeHourForcast.rawValue
        )
        tableView.register(
            OneDayForcastTableViewCell.self,
            forCellReuseIdentifier: TableReuseIdentifiers.oneDayForcast.rawValue
        )
        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: TableReuseIdentifiers.defaultCell.rawValue
        )
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
    }
    ///Настройка хэдера tableView
    private func setupHeaderTableView() {
        headerView = HeaderView(
            frame: CGRect(
                x: .zero,
                y: .zero,
                width: frame.width,
                height: 212.0
            )
        )
        tableView.tableHeaderView = headerView
    }
    ///Настройка UI на основании того должна ли View быть пустой или нет
    func setupView(forEmptyScreen isEmpty: Bool) {
        if isEmpty {
            emptyScreenSetupUI()
            emptyScreenSetupConstraints()
        } else {
            setupUI()
            setupTableView()
            setupHeaderTableView()
            setupConstraints()
        }
    }
    // MARK: - Init
    init() {
        super.init(frame: .zero)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Interface
    ///Загрузка делегатов из контроллера
    func setupTableView(dataSource: UITableViewDataSource, delegate: UITableViewDelegate) {
        tableView.dataSource = dataSource
        tableView.delegate = delegate
    }
    ///Загрузка данных в Header
    lazy var loadDataInHeader: ((ModelProtocol) -> Void) = { [weak self] model in
        guard let self = self else { return }
        self.headerView.loadDataInHeader(model)
    }
    ///Загрузка прогноза в Header
    lazy var loadForcastInHeader: ((ModelProtocol) -> Void) = { [weak self] model in
        guard let self = self else { return }
        self.headerView.loadForcastInHeader(model)
    }
    ///Замыкание для вызова reloadData в коллекции и обновления данных в ThreeHourForcastTableViewCell
    lazy var callToTableView: (() -> Void) = { [weak self] in
        guard let self = self else { return }
        guard let cell = self.tableView.cellForRow(at: [0, 0]) else { return }
        guard let cell = cell as? Updatable else { return }
        cell.updateData()
    }
    ///Замыкание для обновления первой секции в таблице - прогноз на 3 часа
    lazy var callToTableViewReload: (() -> Void) = { [weak self] in
        guard let self = self else { return }
        self.tableView.reloadSections([1], with: .automatic)
    }
    ///Включить заливку экрана серым, когда открывается меню
    lazy var changeFilling: (() -> Void) = { [weak self] in
        guard let self = self else { return }
        if self.fillView.alpha == 0.0 {
            self.fillView.alpha = 0.4
        } else if self.fillView.alpha > 0 {
            self.fillView.alpha = 0.0
        }
    }
}
//MARK: - Ext Setupable
extension MainScreenView: Setupable {
    func setup(withModel model: ModelProtocol) {
        guard let model = model as? MainScreenModel.ViewModel else { return }
        fillView.backgroundColor = model.fillViewBbackgroundColor
        bottomView.backgroundColor = model.bottomViewBackgroundColor
        backgroundColor = model.viewBackgroundColor
    }
}
