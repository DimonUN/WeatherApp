//
//  DailyForecastViewController.swift
//  Weather
//
//  Created by Дмитрий Никоноров on 30.08.2022.
//

import UIKit
///Идентификатор коллекции в модуле суточного прогноза
enum DailyCollectionReuseIdentifiers: String {
    case dateCell
}
///Суточный прогноз
final class DailyForecastViewController: UIViewController {
    //MARK: - Properties
    //View модуля
    private lazy var dailyForecastView: DailyForecastView = {
        let dailyForecastView = DailyForecastView(
            collectionViewDelegate: self,
            collectionViewDataSource: self
        )
        dailyForecastView.toAutoLayout()
        return dailyForecastView
    }()
    ///Константные велечины для коллекции
    private enum ConstantsForCollection {
        static let itemHeight: CGFloat = 40.0
        static let itemWidth: CGFloat = 100.0
        static let leftInsets: CGFloat = 4.0
        static let rightInsets: CGFloat = 4.0
        static let topInsets: CGFloat = 4.0
        static let bottomInsets: CGFloat = 4.0
        static let minimumLineSpacing: CGFloat = 4.0
    }
    ///Модель данных
    private var model: DailyForcastModel
    private var interpritator: Interpritatable
    private var dates: [String]
    private var selectIndex: Int
    //MARK: - Methods
    ///Настройка UI
    private func setupUI() {
        view.backgroundColor = Colors.white.color
        view.addSubviews(dailyForecastView)
    }
    ///Настройка констрейнтов
    private func setupConstraints() {
        [
            dailyForecastView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor
            ),
            dailyForecastView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor
            ),
            dailyForecastView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            dailyForecastView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor
            )
        ].forEach { $0.isActive = true }
    }
    ///Настройка нав бара
    private func setupNavigationBar() {
        navigationItem.title = model.navigationItemTitle
    }
    //MARK: - Lifecyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupNavigationBar()
        dailyForecastView.setup(withModel: model)
    }
    //MARK: - Init
    init(
        model: DailyForcastModel,
        index: Int,
        interpritator: Interpritatable,
        dates: [String]
    ) {
        self.model = model
        self.interpritator = interpritator
        self.dates = dates
        self.selectIndex = index
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: - Ext UICollectionViewDataSource
extension DailyForecastViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        dates.count
    }
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: DailyCollectionReuseIdentifiers.dateCell.rawValue,
            for: indexPath
        ) as! DateCollectionViewCell
        let data = dates[indexPath.row]
        if indexPath.row == selectIndex {
            cell.setupCell(forSelectState: true, withText: data)
        } else {
            cell.setupCell(forSelectState: false, withText: data)
        }
        return cell
    }
}
//MARK: - Ext UICollectionViewDelegateFlowLayout
extension DailyForecastViewController: UICollectionViewDelegateFlowLayout {
    private func itemWidth(
        for width: CGFloat,
        spacing: CGFloat
    ) -> CGFloat {
        return ConstantsForCollection.itemWidth
    }
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(
            width: ConstantsForCollection.itemWidth,
            height: ConstantsForCollection.itemHeight
        )
    }
    func collectionView(
        _  : UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
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
        ConstantsForCollection.minimumLineSpacing
    }
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        ConstantsForCollection.minimumLineSpacing
    }
}
