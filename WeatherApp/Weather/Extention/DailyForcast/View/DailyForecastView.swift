//
//  DailyForecastView.swift
//  Weather
//
//  Created by Дмитрий Никоноров on 21.11.2022.
//

import UIKit

final class DailyForecastView: UIView {
    //MARK: - Properties
    private var collectionViewDelegate: UICollectionViewDelegateFlowLayout
    private var collectionViewDataSource: UICollectionViewDataSource
    ///Коллекция
    private lazy var collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.scrollDirection = .horizontal
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.toAutoLayout()
        return collectionView
    }()
    ///scrollView
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = true
        scrollView.backgroundColor = Colors.white.color
        scrollView.toAutoLayout()
        return scrollView
    }()
    ///contentView для scrollView
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.toAutoLayout()
        return contentView
    }()
    ///Лэйбл с городом
    private lazy var locationLabel: UILabel = {
        let locationLabel = UILabel()
        locationLabel.textAlignment = .left
        locationLabel.numberOfLines = 1
        locationLabel.toAutoLayout()
        return locationLabel
    }()
    //MARK: - Day
    ///Контент вью для прозгоза за день
    private lazy var dayContentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5.0
        view.toAutoLayout()
        return view
    }()
    ///Лэйбл группы контента
    private lazy var dayMainLabel: UILabel = {
        let dayMainLabel = UILabel()
        dayMainLabel.toAutoLayout()
        return dayMainLabel
    }()
    ///Температура
    private lazy var dayTempLabel: UILabel = {
        let dayTempLabel = UILabel()

        dayTempLabel.toAutoLayout()
        return dayTempLabel
    }()
    ///Прогноз на день
    private lazy var dayConditionLabel: UILabel = {
        let dayConditionLabel = UILabel()
        dayConditionLabel.toAutoLayout()
        return dayConditionLabel
    }()
    ///Иконна прогноза
    private lazy var dayConditionImageView: UIImageView = {
        let dayConditionImageView = UIImageView()
        dayConditionImageView.contentMode = .scaleAspectFit
        dayConditionImageView.toAutoLayout()
        return dayConditionImageView
    }()
    ///Иконка ощущается как
    private lazy var dayFeelsLikeImageView: UIImageView = {
        let dayFeelsLikeImageView = UIImageView()
        dayFeelsLikeImageView.contentMode = .scaleAspectFit
        dayFeelsLikeImageView.toAutoLayout()
        return dayFeelsLikeImageView
    }()
    ///Иконка ветер
    private lazy var dayWindSpeedImageView: UIImageView = {
        let dayWindSpeedImageView = UIImageView()
        dayWindSpeedImageView.contentMode = .scaleAspectFit
        dayWindSpeedImageView.toAutoLayout()
        return dayWindSpeedImageView
    }()
    ///Иконка UV индекс
    private lazy var dayUVIndexImageView: UIImageView = {
        let dayUVIndexImageView = UIImageView()
        dayUVIndexImageView.contentMode = .scaleAspectFit
        dayUVIndexImageView.toAutoLayout()
        return dayUVIndexImageView
    }()
    ///Иконка облачности
    private lazy var dayCloudnessImageView: UIImageView = {
        let dayCloudnessImageView = UIImageView()
        dayCloudnessImageView.contentMode = .scaleAspectFit
        dayCloudnessImageView.toAutoLayout()
        return dayCloudnessImageView
    }()
    ///Лэйбл ощущуается как
    private lazy var dayFeelsLikeLabel: UILabel = {
        let dayFeelsLikeLabel = UILabel()
        dayFeelsLikeLabel.toAutoLayout()
        return dayFeelsLikeLabel
    }()
    ///Лэйбл ветер
    private lazy var dayWindSpeedLabel: UILabel = {
        let dayWindSpeedLabel = UILabel()
        dayWindSpeedLabel.toAutoLayout()
        return dayWindSpeedLabel
    }()
    ///Лэйбл UV индекс
    private lazy var dayUVIndexLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        return label
    }()
    ///Лэйбл облачности
    private lazy var dayCloudnessLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        return label
    }()
    ///Значение ощущуается как
    private lazy var dayValueFeelsLikeLabel: UILabel = {
        let dayValueFeelsLikeLabel = UILabel()
        dayValueFeelsLikeLabel.toAutoLayout()
        return dayValueFeelsLikeLabel
    }()
    ///Значение ветер
    private lazy var dayValueWindSpeedLabel: UILabel = {
        let dayValueWindSpeedLabel = UILabel()
        dayValueWindSpeedLabel.toAutoLayout()
        return dayValueWindSpeedLabel
    }()
    ///Значение UV индекс
    private lazy var dayValueUVIndexLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        return label
    }()
    ///Значение облачности
    private lazy var dayValueCloudnessLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        return label
    }()
    ///Разделительные линии
    private lazy var oneDaySeparationLineView: UIView = {
        let separationLine = UIView()
        separationLine.backgroundColor = Colors.blue.color

        separationLine.toAutoLayout()
        return separationLine
    }()
    private lazy var twoDaySeparationLineView: UIView = {
        let separationLine = UIView()
        separationLine.backgroundColor = Colors.blue.color

        separationLine.toAutoLayout()
        return separationLine
    }()
    private lazy var threeDaySeparationLineView: UIView = {
        let separationLine = UIView()
        separationLine.backgroundColor = Colors.blue.color

        separationLine.toAutoLayout()
        return separationLine
    }()
    private lazy var fourDaySeparationLineView: UIView = {
        let separationLine = UIView()
        separationLine.backgroundColor = Colors.blue.color

        separationLine.toAutoLayout()
        return separationLine
    }()
    //MARK: - Nigth
    ///Контент вью для прозгоза за ночь
    private lazy var nightContentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5.0
        view.toAutoLayout()
        return view
    }()
    ///Лэйбл группы контента
    private lazy var nightMainLabel: UILabel = {
        let dayMainLabel = UILabel()
        dayMainLabel.toAutoLayout()
        return dayMainLabel
    }()
    ///Температура
    private lazy var nightTempLabel: UILabel = {
        let dayTempLabel = UILabel()

        dayTempLabel.toAutoLayout()
        return dayTempLabel
    }()
    ///Прогноз на день
    private lazy var nightConditionLabel: UILabel = {
        let dayConditionLabel = UILabel()
        dayConditionLabel.toAutoLayout()
        return dayConditionLabel
    }()
    ///Иконна прогноза
    private lazy var nightConditionImageView: UIImageView = {
        let dayConditionImageView = UIImageView()
        dayConditionImageView.contentMode = .scaleAspectFit
        dayConditionImageView.toAutoLayout()
        return dayConditionImageView
    }()
    ///Иконка ощущается как
    private lazy var nightFeelsLikeImageView: UIImageView = {
        let dayFeelsLikeImageView = UIImageView()
        dayFeelsLikeImageView.contentMode = .scaleAspectFit
        dayFeelsLikeImageView.toAutoLayout()
        return dayFeelsLikeImageView
    }()
    ///Иконка ветер
    private lazy var nightWindSpeedImageView: UIImageView = {
        let dayWindSpeedImageView = UIImageView()
        dayWindSpeedImageView.contentMode = .scaleAspectFit
        dayWindSpeedImageView.toAutoLayout()
        return dayWindSpeedImageView
    }()
    ///Иконка UV индекс
    private lazy var nightUVIndexImageView: UIImageView = {
        let dayUVIndexImageView = UIImageView()
        dayUVIndexImageView.contentMode = .scaleAspectFit
        dayUVIndexImageView.toAutoLayout()
        return dayUVIndexImageView
    }()
    ///Иконка облачности
    private lazy var nightCloudnessImageView: UIImageView = {
        let dayCloudnessImageView = UIImageView()
        dayCloudnessImageView.contentMode = .scaleAspectFit
        dayCloudnessImageView.toAutoLayout()
        return dayCloudnessImageView
    }()
    ///Лэйбл ощущуается как
    private lazy var nightFeelsLikeLabel: UILabel = {
        let dayFeelsLikeLabel = UILabel()
        dayFeelsLikeLabel.toAutoLayout()
        return dayFeelsLikeLabel
    }()
    ///Лэйбл ветер
    private lazy var nightWindSpeedLabel: UILabel = {
        let dayWindSpeedLabel = UILabel()
        dayWindSpeedLabel.toAutoLayout()
        return dayWindSpeedLabel
    }()
    ///Лэйбл UV индекс
    private lazy var nightUVIndexLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        return label
    }()
    ///Лэйбл облачности
    private lazy var nightCloudnessLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        return label
    }()
    ///Значение ощущуается как
    private lazy var nightValueFeelsLikeLabel: UILabel = {
        let dayValueFeelsLikeLabel = UILabel()
        dayValueFeelsLikeLabel.toAutoLayout()
        return dayValueFeelsLikeLabel
    }()
    ///Значение ветер
    private lazy var nightValueWindSpeedLabel: UILabel = {
        let dayValueWindSpeedLabel = UILabel()
        dayValueWindSpeedLabel.toAutoLayout()
        return dayValueWindSpeedLabel
    }()
    ///Значение UV индекс
    private lazy var nightValueUVIndexLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        return label
    }()
    ///Значение облачности
    private lazy var nightValueCloudnessLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        return label
    }()
    ///Разделительные линии
    private lazy var oneNightSeparationLineView: UIView = {
        let separationLine = UIView()
        separationLine.backgroundColor = Colors.blue.color

        separationLine.toAutoLayout()
        return separationLine
    }()
    private lazy var twoNightSeparationLineView: UIView = {
        let separationLine = UIView()
        separationLine.backgroundColor = Colors.blue.color

        separationLine.toAutoLayout()
        return separationLine
    }()
    private lazy var threeNightSeparationLineView: UIView = {
        let separationLine = UIView()
        separationLine.backgroundColor = Colors.blue.color

        separationLine.toAutoLayout()
        return separationLine
    }()
    private lazy var fourNightSeparationLineView: UIView = {
        let separationLine = UIView()
        separationLine.backgroundColor = Colors.blue.color

        separationLine.toAutoLayout()
        return separationLine
    }()
    ///Подложка блока про солнце
    private lazy var sunContentView: UIView = {
        let view = UIView()
        view.toAutoLayout()
        return view
    }()
    ///Заголовок блока про солнце
    private lazy var sunTitleLabel: UILabel = {
        let sunTitleLabel = UILabel()
        sunTitleLabel.toAutoLayout()
        return sunTitleLabel
    }()
    ///Вертикальный разделитель
    private lazy var verticalSeparator: UIView = {
        let verticalSeparator = UIView()
        verticalSeparator.backgroundColor = Colors.blue.color
        verticalSeparator.toAutoLayout()
        return verticalSeparator
    }()
    ///Надпись воход
    private lazy var sunriseLabel: UILabel = {
        let sunriseLabel = UILabel()
        sunriseLabel.toAutoLayout()
        return sunriseLabel
    }()
    ///Время восхода солнца
    private lazy var sunriseTimeLabel: UILabel = {
        let sunriseTimeLabel = UILabel()
        sunriseTimeLabel.toAutoLayout()
        return sunriseTimeLabel
    }()
    ///Надпись заход
    private lazy var sunsetLabel: UILabel = {
        let sunriseLabel = UILabel()
        sunriseLabel.toAutoLayout()
        return sunriseLabel
    }()
    ///Время захода солнца
    private lazy var sunsetTimeLabel: UILabel = {
        let sunriseTimeLabel = UILabel()
        sunriseTimeLabel.toAutoLayout()
        return sunriseTimeLabel
    }()
    ///Иконка солнечного дня
    private lazy var solarImageView: UIImageView = {
        let solarImageView = UIImageView()
        solarImageView.contentMode = .scaleAspectFit
        solarImageView.toAutoLayout()
        return solarImageView
    }()
    ///Продолжительность светового дня
    private lazy var solarTimeLabel: UILabel = {
        let solarTimeLabel = UILabel()
        solarTimeLabel.toAutoLayout()
        return solarTimeLabel
    }()
    //MARK: - Methods
    ///Настройка коллекции
    private func setupCollectionView() {
        collectionView.dataSource = collectionViewDataSource
        collectionView.delegate = collectionViewDelegate
        collectionView.register(
            DateCollectionViewCell.self,
            forCellWithReuseIdentifier: DailyCollectionReuseIdentifiers.dateCell.rawValue
        )
    }
    ///Настройка UI
    private func setupUI() {
        addSubviews(locationLabel, scrollView, collectionView)
        scrollView.addSubviews(contentView)
        contentView.addSubviews(dayContentView, nightContentView, sunContentView)
        dayContentView.addSubviews(
            dayMainLabel,
            dayTempLabel,
            dayConditionLabel,
            dayConditionImageView,
            dayFeelsLikeImageView,
            dayFeelsLikeLabel,
            dayValueFeelsLikeLabel,
            oneDaySeparationLineView,
            dayWindSpeedImageView,
            dayWindSpeedLabel,
            dayValueWindSpeedLabel,
            twoDaySeparationLineView,
            dayUVIndexImageView,
            dayUVIndexLabel,
            dayValueUVIndexLabel,
            threeDaySeparationLineView,
            fourDaySeparationLineView,
            dayCloudnessImageView,
            dayCloudnessLabel,
            dayValueCloudnessLabel
        )
        nightContentView.addSubviews(
            nightMainLabel,
            nightTempLabel,
            nightConditionLabel,
            nightConditionImageView,
            nightFeelsLikeImageView,
            nightFeelsLikeLabel,
            nightValueFeelsLikeLabel,
            oneNightSeparationLineView,
            nightWindSpeedImageView,
            nightWindSpeedLabel,
            nightValueWindSpeedLabel,
            twoNightSeparationLineView,
            nightUVIndexImageView,
            nightUVIndexLabel,
            nightValueUVIndexLabel,
            threeNightSeparationLineView,
            fourNightSeparationLineView,
            nightCloudnessImageView,
            nightCloudnessLabel,
            nightValueCloudnessLabel
        )
        sunContentView.addSubviews(
            sunTitleLabel,
            verticalSeparator,
            sunriseLabel,
            sunriseTimeLabel,
            sunsetLabel,
            sunsetTimeLabel,
            solarImageView,
            solarTimeLabel
        )
    }
    ///Настройка констрейнтов
    private func setupConstraints() {
        ///add to view
        [
            ///locationLabel
            locationLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 16.0
            ),
            locationLabel.topAnchor.constraint(
                equalTo: topAnchor
            ),
            locationLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -16.0
            ),
            locationLabel.heightAnchor.constraint(
                equalToConstant: 22.0
            ),
            ///collection
            collectionView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 0
            ),
            collectionView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: 0
            ),
            collectionView.topAnchor.constraint(
                equalTo: locationLabel.bottomAnchor,
                constant: 20.0
            ),
            collectionView.heightAnchor.constraint(
                equalToConstant: 40.0
            ),
            ///scrollView
            scrollView.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor
            ),
            scrollView.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor
            ),
            scrollView.topAnchor.constraint(
                equalTo: locationLabel.bottomAnchor,
                constant: 68.0
            ),
            scrollView.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor
            ),
            ///contentView
            contentView.leadingAnchor.constraint(
                equalTo: scrollView.leadingAnchor
            ),
            contentView.trailingAnchor.constraint(
                equalTo: scrollView.trailingAnchor
            ),
            contentView.topAnchor.constraint(
                equalTo: scrollView.topAnchor
            ),
            contentView.bottomAnchor.constraint(
                equalTo: scrollView.bottomAnchor
            ),
            contentView.widthAnchor.constraint(
                equalTo: scrollView.widthAnchor
            ),
            ///dayContentView
            dayContentView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 16.0
            ),
            dayContentView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -16.0
            ),
            dayContentView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 0
            ),
            dayContentView.heightAnchor.constraint(
                equalToConstant: 320.0
            ),
            ///nightContentView
            nightContentView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 16.0
            ),
            nightContentView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -16.0
            ),
            nightContentView.topAnchor.constraint(
                equalTo: dayContentView.bottomAnchor,
                constant: 12.0
            ),
            nightContentView.heightAnchor.constraint(
                equalToConstant: 320.0
            ),
            ///sunContentView
            sunContentView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 16.0
            ),
            sunContentView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -16.0
            ),
            sunContentView.topAnchor.constraint(
                equalTo: nightContentView.bottomAnchor,
                constant: 12.0
            ),
            sunContentView.heightAnchor.constraint(
                equalToConstant: 160.0
            ),
            sunContentView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor
            )
        ].forEach { $0.isActive = true }
        ///add to  dayContentView
        [
            ///sunContentView
            dayMainLabel.leadingAnchor.constraint(
                equalTo: dayContentView.leadingAnchor,
                constant: 16.0
            ),
            dayMainLabel.topAnchor.constraint(
                equalTo: dayContentView.topAnchor,
                constant: 20.0
            ),
            ///dayTempLabel
            dayTempLabel.centerXAnchor.constraint(
                equalTo: dayContentView.centerXAnchor,
                constant: 0
            ),
            dayTempLabel.topAnchor.constraint(
                equalTo: dayContentView.topAnchor,
                constant: 16.0
            ),
            dayTempLabel.heightAnchor.constraint(
                equalToConstant: 36.0
            ),
            dayTempLabel.widthAnchor.constraint(
                equalToConstant: 32.0
            ),
            ///dayConditionImageView
            dayConditionImageView.trailingAnchor.constraint(
                equalTo: dayTempLabel.leadingAnchor,
                constant: -10.0
            ),
            dayConditionImageView.centerYAnchor.constraint(
                equalTo: dayTempLabel.centerYAnchor
            ),
            dayConditionImageView.heightAnchor.constraint(
                equalTo: dayTempLabel.heightAnchor,
                constant: -10.0
            ),
            dayConditionImageView.widthAnchor.constraint(
                equalTo: dayConditionImageView.heightAnchor
            ),
            dayConditionLabel.centerXAnchor.constraint(
                equalTo: dayContentView.centerXAnchor,
                constant: 0
            ),
            dayConditionLabel.topAnchor.constraint(
                equalTo: dayTempLabel.bottomAnchor,
                constant: 10.0
            ),
            ///dayFeelsLikeImageView
            dayFeelsLikeImageView.leadingAnchor.constraint(
                equalTo: dayContentView.leadingAnchor,
                constant: 16.0
            ),
            dayFeelsLikeImageView.topAnchor.constraint(
                equalTo: dayConditionLabel.bottomAnchor,
                constant: 24.0
            ),
            dayFeelsLikeImageView.widthAnchor.constraint(
                equalToConstant: 24.0
            ),
            dayFeelsLikeImageView.heightAnchor.constraint(
                equalToConstant: 26.0
            ),
            ///dayFeelsLikeLabel
            dayFeelsLikeLabel.centerYAnchor.constraint(
                equalTo: dayFeelsLikeImageView.centerYAnchor
            ),
            dayFeelsLikeLabel.leadingAnchor.constraint(
                equalTo: dayFeelsLikeImageView.trailingAnchor,
                constant: 16.0
            ),
            ///dayValueFeelsLikeLabel
            dayValueFeelsLikeLabel.centerYAnchor.constraint(
                equalTo: dayFeelsLikeImageView.centerYAnchor
            ),
            dayValueFeelsLikeLabel.trailingAnchor.constraint(
                equalTo: dayContentView.trailingAnchor,
                constant: -20.0
            ),
            ///oneDaySeparationLineView
            oneDaySeparationLineView.leadingAnchor.constraint(
                equalTo: dayContentView.leadingAnchor
            ),
            oneDaySeparationLineView.trailingAnchor.constraint(
                equalTo: dayContentView.trailingAnchor
            ),
            oneDaySeparationLineView.heightAnchor.constraint(
                equalToConstant: 1.0
            ),
            oneDaySeparationLineView.topAnchor.constraint(
                equalTo: dayFeelsLikeLabel.bottomAnchor,
                constant: 16.0
            ),
            ///dayWindSpeedImageView
            dayWindSpeedImageView.leadingAnchor.constraint(
                equalTo: dayContentView.leadingAnchor,
                constant: 16.0
            ),
            dayWindSpeedImageView.topAnchor.constraint(
                equalTo: oneDaySeparationLineView.bottomAnchor,
                constant: 16.0
            ),
            dayWindSpeedImageView.widthAnchor.constraint(
                equalToConstant: 24.0
            ),
            dayWindSpeedImageView.heightAnchor.constraint(
                equalToConstant: 26.0
            ),
            ///dayWindSpeedLabel
            dayWindSpeedLabel.centerYAnchor.constraint(
                equalTo: dayWindSpeedImageView.centerYAnchor
            ),
            dayWindSpeedLabel.leadingAnchor.constraint(
                equalTo: dayWindSpeedImageView.trailingAnchor,
                constant: 16.0
            ),
            dayValueWindSpeedLabel.centerYAnchor.constraint(
                equalTo: dayWindSpeedImageView.centerYAnchor
            ),
            dayValueWindSpeedLabel.trailingAnchor.constraint(
                equalTo: dayContentView.trailingAnchor,
                constant: -20.0
            ),
            ///twoDaySeparationLineView
            twoDaySeparationLineView.leadingAnchor.constraint(
                equalTo: dayContentView.leadingAnchor
            ),
            twoDaySeparationLineView.trailingAnchor.constraint(
                equalTo: dayContentView.trailingAnchor
            ),
            twoDaySeparationLineView.heightAnchor.constraint(
                equalToConstant: 1.0
            ),
            twoDaySeparationLineView.topAnchor.constraint(
                equalTo: dayWindSpeedLabel.bottomAnchor,
                constant: 16.0
            ),
            ///dayUVIndexImageView
            dayUVIndexImageView.leadingAnchor.constraint(
                equalTo: dayContentView.leadingAnchor,
                constant: 16.0
            ),
            dayUVIndexImageView.topAnchor.constraint(
                equalTo: twoDaySeparationLineView.bottomAnchor,
                constant: 16.0
            ),
            dayUVIndexImageView.widthAnchor.constraint(
                equalToConstant: 24.0
            ),
            dayUVIndexImageView.heightAnchor.constraint(
                equalToConstant: 26.0
            ),
            ///dayUVIndexLabel
            dayUVIndexLabel.centerYAnchor.constraint(
                equalTo: dayUVIndexImageView.centerYAnchor
            ),
            dayUVIndexLabel.leadingAnchor.constraint(
                equalTo: dayUVIndexImageView.trailingAnchor,
                constant: 16.0
            ),
            ///dayValueUVIndexLabel
            dayValueUVIndexLabel.centerYAnchor.constraint(
                equalTo: dayUVIndexImageView.centerYAnchor
            ),
            dayValueUVIndexLabel.trailingAnchor.constraint(
                equalTo: dayContentView.trailingAnchor,
                constant: -20.0
            ),
            ///threeDaySeparationLineView
            threeDaySeparationLineView.leadingAnchor.constraint(
                equalTo: dayContentView.leadingAnchor
            ),
            threeDaySeparationLineView.trailingAnchor.constraint(
                equalTo: dayContentView.trailingAnchor
            ),
            threeDaySeparationLineView.heightAnchor.constraint(
                equalToConstant: 1.0
            ),
            threeDaySeparationLineView.topAnchor.constraint(
                equalTo: dayUVIndexLabel.bottomAnchor,
                constant: 16.0
            ),
            ///dayCloudnessImageView
            dayCloudnessImageView.leadingAnchor.constraint(
                equalTo: dayContentView.leadingAnchor,
                constant: 16.0
            ),
            dayCloudnessImageView.topAnchor.constraint(
                equalTo: threeDaySeparationLineView.bottomAnchor,
                constant: 16.0
            ),
            dayCloudnessImageView.widthAnchor.constraint(
                equalToConstant: 24.0
            ),
            dayCloudnessImageView.heightAnchor.constraint(
                equalToConstant: 26.0
            ),
            ///dayCloudnessLabel
            dayCloudnessLabel.centerYAnchor.constraint(
                equalTo: dayCloudnessImageView.centerYAnchor
            ),
            dayCloudnessLabel.leadingAnchor.constraint(
                equalTo: dayCloudnessImageView.trailingAnchor,
                constant: 16.0
            ),
            ///dayValueCloudnessLabel
            dayValueCloudnessLabel.centerYAnchor.constraint(
                equalTo: dayCloudnessImageView.centerYAnchor
            ),
            dayValueCloudnessLabel.trailingAnchor.constraint(
                equalTo: dayContentView.trailingAnchor,
                constant: -20.0
            )
        ].forEach { $0.isActive = true }
        ///add to  nightContentView
        [
            ///nightMainLabel
            nightMainLabel.leadingAnchor.constraint(
                equalTo: nightContentView.leadingAnchor,
                constant: 16.0
            ),
            nightMainLabel.topAnchor.constraint(
                equalTo: nightContentView.topAnchor,
                constant: 20.0
            ),
            ///nightTempLabel
            nightTempLabel.centerXAnchor.constraint(
                equalTo: nightContentView.centerXAnchor,
                constant: 0
            ),
            nightTempLabel.topAnchor.constraint(
                equalTo: nightContentView.topAnchor,
                constant: 16.0
            ),
            nightTempLabel.heightAnchor.constraint(
                equalToConstant: 36.0
            ),
            nightTempLabel.widthAnchor.constraint(
                equalToConstant: 32.0
            ),
            ///nightConditionImageView
            nightConditionImageView.trailingAnchor.constraint(
                equalTo: nightTempLabel.leadingAnchor,
                constant: -10.0
            ),
            nightConditionImageView.centerYAnchor.constraint(
                equalTo: nightTempLabel.centerYAnchor
            ),
            nightConditionImageView.heightAnchor.constraint(
                equalTo: nightTempLabel.heightAnchor,
                constant: -10.0
            ),
            nightConditionImageView.widthAnchor.constraint(
                equalTo: nightConditionImageView.heightAnchor
            ),
            ///nightConditionLabel
            nightConditionLabel.centerXAnchor.constraint(
                equalTo: nightContentView.centerXAnchor,
                constant: 0
            ),
            nightConditionLabel.topAnchor.constraint(
                equalTo: nightTempLabel.bottomAnchor,
                constant: 10.0
            ),
            ///nightFeelsLikeImageView
            nightFeelsLikeImageView.leadingAnchor.constraint(
                equalTo: nightContentView.leadingAnchor,
                constant: 16.0
            ),
            nightFeelsLikeImageView.topAnchor.constraint(
                equalTo: nightConditionLabel.bottomAnchor,
                constant: 24.0
            ),
            nightFeelsLikeImageView.widthAnchor.constraint(
                equalToConstant: 24.0
            ),
            nightFeelsLikeImageView.heightAnchor.constraint(
                equalToConstant: 26.0
            ),
            ///nightFeelsLikeLabel
            nightFeelsLikeLabel.centerYAnchor.constraint(
                equalTo: nightFeelsLikeImageView.centerYAnchor
            ),
            nightFeelsLikeLabel.leadingAnchor.constraint(
                equalTo: nightFeelsLikeImageView.trailingAnchor,
                constant: 16.0
            ),
            nightValueFeelsLikeLabel.centerYAnchor.constraint(
                equalTo: nightFeelsLikeImageView.centerYAnchor
            ),
            nightValueFeelsLikeLabel.trailingAnchor.constraint(
                equalTo: nightContentView.trailingAnchor,
                constant: -20.0
            ),
            ///oneNightSeparationLineView
            oneNightSeparationLineView.leadingAnchor.constraint(
                equalTo: nightContentView.leadingAnchor
            ),
            oneNightSeparationLineView.trailingAnchor.constraint(
                equalTo: dayContentView.trailingAnchor
            ),
            oneNightSeparationLineView.heightAnchor.constraint(
                equalToConstant: 1.0
            ),
            oneNightSeparationLineView.topAnchor.constraint(
                equalTo: nightFeelsLikeLabel.bottomAnchor,
                constant: 16.0
            ),
            ///nightWindSpeedImageView
            nightWindSpeedImageView.leadingAnchor.constraint(
                equalTo: nightContentView.leadingAnchor,
                constant: 16.0
            ),
            nightWindSpeedImageView.topAnchor.constraint(
                equalTo: oneNightSeparationLineView.bottomAnchor,
                constant: 16.0
            ),
            nightWindSpeedImageView.widthAnchor.constraint(
                equalToConstant: 24.0
            ),
            nightWindSpeedImageView.heightAnchor.constraint(
                equalToConstant: 26.0
            ),
            ///nightWindSpeedLabel
            nightWindSpeedLabel.centerYAnchor.constraint(
                equalTo: nightWindSpeedImageView.centerYAnchor
            ),
            nightWindSpeedLabel.leadingAnchor.constraint(
                equalTo: nightWindSpeedImageView.trailingAnchor,
                constant: 16.0
            ),
            ///nightValueWindSpeedLabel
            nightValueWindSpeedLabel.centerYAnchor.constraint(
                equalTo: nightWindSpeedImageView.centerYAnchor
            ),
            nightValueWindSpeedLabel.trailingAnchor.constraint(
                equalTo: nightContentView.trailingAnchor,
                constant: -20.0
            ),
            ///twoNightSeparationLineView
            twoNightSeparationLineView.leadingAnchor.constraint(
                equalTo: nightContentView.leadingAnchor
            ),
            twoNightSeparationLineView.trailingAnchor.constraint(
                equalTo: nightContentView.trailingAnchor
            ),
            twoNightSeparationLineView.heightAnchor.constraint(
                equalToConstant: 1.0
            ),
            twoNightSeparationLineView.topAnchor.constraint(
                equalTo: nightWindSpeedLabel.bottomAnchor,
                constant: 16.0
            ),
            ///nightUVIndexImageView
            nightUVIndexImageView.leadingAnchor.constraint(
                equalTo: nightContentView.leadingAnchor,
                constant: 16.0
            ),
            nightUVIndexImageView.topAnchor.constraint(
                equalTo: twoNightSeparationLineView.bottomAnchor,
                constant: 16.0
            ),
            nightUVIndexImageView.widthAnchor.constraint(
                equalToConstant: 24.0
            ),
            nightUVIndexImageView.heightAnchor.constraint(
                equalToConstant: 26.0
            ),
            ///nightUVIndexLabel
            nightUVIndexLabel.centerYAnchor.constraint(
                equalTo: nightUVIndexImageView.centerYAnchor
            ),
            nightUVIndexLabel.leadingAnchor.constraint(
                equalTo: nightUVIndexImageView.trailingAnchor,
                constant: 16.0
            ),
            ///nightValueUVIndexLabel
            nightValueUVIndexLabel.centerYAnchor.constraint(
                equalTo: nightUVIndexImageView.centerYAnchor
            ),
            nightValueUVIndexLabel.trailingAnchor.constraint(
                equalTo: nightContentView.trailingAnchor,
                constant: -20.0
            ),
            ///threeNightSeparationLineView
            threeNightSeparationLineView.leadingAnchor.constraint(
                equalTo: nightContentView.leadingAnchor
            ),
            threeNightSeparationLineView.trailingAnchor.constraint(
                equalTo: nightContentView.trailingAnchor
            ),
            threeNightSeparationLineView.heightAnchor.constraint(
                equalToConstant: 1.0
            ),
            threeNightSeparationLineView.topAnchor.constraint(
                equalTo: nightUVIndexLabel.bottomAnchor,
                constant: 16.0
            ),
            ///nightCloudnessImageView
            nightCloudnessImageView.leadingAnchor.constraint(
                equalTo: nightContentView.leadingAnchor,
                constant: 16.0
            ),
            nightCloudnessImageView.topAnchor.constraint(
                equalTo: threeNightSeparationLineView.bottomAnchor,
                constant: 16.0
            ),
            nightCloudnessImageView.widthAnchor.constraint(
                equalToConstant: 24.0
            ),
            nightCloudnessImageView.heightAnchor.constraint(
                equalToConstant: 26.0
            ),
            ///nightCloudnessLabel
            nightCloudnessLabel.centerYAnchor.constraint(
                equalTo: nightCloudnessImageView.centerYAnchor
            ),
            nightCloudnessLabel.leadingAnchor.constraint(
                equalTo: nightCloudnessImageView.trailingAnchor,
                constant: 16.0
            ),
            ///nightValueCloudnessLabel
            nightValueCloudnessLabel.centerYAnchor.constraint(
                equalTo: nightCloudnessImageView.centerYAnchor
            ),
            nightValueCloudnessLabel.trailingAnchor.constraint(
                equalTo: nightContentView.trailingAnchor,
                constant: -20.0
            )
        ].forEach { $0.isActive = true }
        ///add to sunContentView
        [
            ///sunTitleLabel
            sunTitleLabel.leadingAnchor.constraint(
                equalTo: sunContentView.leadingAnchor
            ),
            sunTitleLabel.topAnchor.constraint(
                equalTo: sunContentView.topAnchor,
                constant: 8
            ),
            ///verticalSeparator
            verticalSeparator.centerXAnchor.constraint(
                equalTo: sunContentView.centerXAnchor
            ),
            verticalSeparator.topAnchor.constraint(
                equalTo: sunTitleLabel.bottomAnchor,
                constant: 16.0
            ),
            verticalSeparator.widthAnchor.constraint(
                equalToConstant: 1.0
            ),
            verticalSeparator.heightAnchor.constraint(
                equalToConstant: 60.0
            ),
            ///sunriseLabel
            sunriseLabel.centerYAnchor.constraint(
                equalTo: verticalSeparator.centerYAnchor
            ),
            sunriseLabel.leadingAnchor.constraint(
                equalTo: sunContentView.leadingAnchor,
                constant: 18.0
            ),
            ///sunriseTimeLabel
            sunriseTimeLabel.centerYAnchor.constraint(
                equalTo: verticalSeparator.centerYAnchor
            ),
            sunriseTimeLabel.trailingAnchor.constraint(
                equalTo: verticalSeparator.leadingAnchor,
                constant: -16.0
            ),
            ///sunsetLabel
            sunsetLabel.centerYAnchor.constraint(
                equalTo: verticalSeparator.centerYAnchor
            ),
            sunsetLabel.trailingAnchor.constraint(
                equalTo: sunContentView.trailingAnchor,
                constant: -18.0
            ),
            ///sunsetTimeLabel
            sunsetTimeLabel.centerYAnchor.constraint(
                equalTo: verticalSeparator.centerYAnchor
            ),
            sunsetTimeLabel.leadingAnchor.constraint(
                equalTo: verticalSeparator.trailingAnchor,
                constant: 16.0
            ),
            ///solarTimeLabel
            solarTimeLabel.trailingAnchor.constraint(
                equalTo: sunContentView.trailingAnchor,
                constant: -16.0
            ),
            solarTimeLabel.centerYAnchor.constraint(
                equalTo: sunTitleLabel.centerYAnchor
            ),
            ///solarImageView
            solarImageView.centerYAnchor.constraint(
                equalTo: sunTitleLabel.centerYAnchor
            ),
            solarImageView.trailingAnchor.constraint(
                equalTo: solarTimeLabel.leadingAnchor,
                constant: -16
            )
        ].forEach { $0.isActive = true }
    }
    //MARK: - Init
    init(
        collectionViewDelegate: UICollectionViewDelegateFlowLayout,
        collectionViewDataSource: UICollectionViewDataSource
    ) {
        self.collectionViewDelegate = collectionViewDelegate
        self.collectionViewDataSource = collectionViewDataSource
        super.init(frame: .zero)
        setupUI()
        setupConstraints()
        setupCollectionView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: - Extention Setupable
extension DailyForecastView: Setupable {
    func setup(withModel model: ModelProtocol) {
        guard let model = model as? DailyForcastModel else { return }
        let viewModel = model.viewModel
        dayContentView.backgroundColor = viewModel.dayContentViewBackgroundColor
        nightContentView.backgroundColor = viewModel.nightContentViewBackgroundColor

        dayMainLabel.textColor = viewModel.dayMainLabelTextColor
        dayMainLabel.attributedText = NSMutableAttributedString(
            string: viewModel.dayMainText,
            attributes: viewModel.dayMainTextAttributes
        )
        dayMainLabel.font = viewModel.dayMainLabelFont

        dayCloudnessImageView.image = viewModel.dayCloudnessImage
        dayFeelsLikeImageView.image = viewModel.dayFeelsLikeImage
        dayWindSpeedImageView.image = viewModel.dayWindSpeedImage
        dayUVIndexImageView.image = viewModel.dayUVIndexImage
        solarImageView.image = viewModel.solarImage

        dayFeelsLikeLabel.textColor = viewModel.dayFeelsLikeLabelTextColor
        dayFeelsLikeLabel.attributedText = NSMutableAttributedString(
            string: viewModel.dayFeelsLikeText,
            attributes: viewModel.dayFeelsLikeLabelAttributes
        )
        dayFeelsLikeLabel.font = viewModel.dayFeelsLikeLabelFont

        dayWindSpeedLabel.textColor = viewModel.dayWindSpeedLabelTextColor
        dayWindSpeedLabel.attributedText = NSMutableAttributedString(
            string: viewModel.dayWindSpeedText,
            attributes: viewModel.dayWindSpeedLabelAttributes
        )
        dayWindSpeedLabel.font = viewModel.dayWindSpeedLabelFont

        dayUVIndexLabel.textColor = viewModel.dayUVIndexLabelTextColor
        dayUVIndexLabel.attributedText = NSMutableAttributedString(
            string: viewModel.dayUVIndexText,
            attributes: viewModel.dayUVIndexLabelAttributes
        )
        dayUVIndexLabel.font = viewModel.dayUVIndexLabelFont

        dayCloudnessLabel.textColor = viewModel.dayCloudnessLabelTextColor
        dayCloudnessLabel.attributedText = NSMutableAttributedString(
            string: viewModel.dayCloudnessText,
            attributes: viewModel.dayCloudnessLabelAttributes
        )
        dayCloudnessLabel.font = viewModel.dayCloudnessLabelFont

        nightMainLabel.textColor = viewModel.nightMainLabelTextColor
        nightMainLabel.attributedText = NSMutableAttributedString(
            string: viewModel.nightMainText,
            attributes: viewModel.nightMainLabelAttributes
        )
        nightMainLabel.font = viewModel.nightMainLabelFont

        nightCloudnessImageView.image = viewModel.nightCloudnessImage
        nightFeelsLikeImageView.image = viewModel.nightFeelsLikeImage
        nightWindSpeedImageView.image = viewModel.nightWindSpeedImage
        nightUVIndexImageView.image = viewModel.nightUVIndexImage

        nightFeelsLikeLabel.textColor = viewModel.nightFeelsLikeLabelTextColor
        nightFeelsLikeLabel.attributedText = NSMutableAttributedString(
            string: viewModel.nightFeelsLikeText,
            attributes: viewModel.nightFeelsLikeLabelAttributes
        )
        nightFeelsLikeLabel.font = viewModel.nightFeelsLikeLabelFont

        nightWindSpeedLabel.textColor = viewModel.nightWindSpeedLabelTextColor
        nightWindSpeedLabel.attributedText = NSMutableAttributedString(
            string: viewModel.nightWindSpeedText,
            attributes: viewModel.nightWindSpeedLabelAttributes
        )
        nightWindSpeedLabel.font = viewModel.nightWindSpeedLabelFont

        nightUVIndexLabel.textColor = viewModel.nightUVIndexLabelTextColor
        nightUVIndexLabel.attributedText = NSMutableAttributedString(
            string: viewModel.nightUVIndexText,
            attributes: viewModel.nightUVIndexLabelAttributes
        )
        nightUVIndexLabel.font = viewModel.nightUVIndexLabelFont

        nightCloudnessLabel.textColor = viewModel.nightCloudnessLabelTextColor
        nightCloudnessLabel.attributedText = NSMutableAttributedString(
            string: viewModel.nightCloudnessText,
            attributes: viewModel.nightCloudnessLabelAttributes
        )
        nightCloudnessLabel.font = viewModel.nightCloudnessLabelFont

        sunTitleLabel.textColor = viewModel.sunTitleLabelTextColor
        sunTitleLabel.attributedText = NSMutableAttributedString(
            string: viewModel.sunTitleText,
            attributes: viewModel.sunTitleLabelAttributes
        )
        sunTitleLabel.font = viewModel.sunTitleLabelFont

        sunriseLabel.textColor = viewModel.sunriseLabelTextColor
        sunriseLabel.attributedText = NSMutableAttributedString(
            string: viewModel.sunriseText,
            attributes: viewModel.sunriseLabelAttributes
        )
        sunriseLabel.font = viewModel.sunriseLabelFont

        sunsetLabel.textColor = viewModel.sunriseLabelTextColor
        sunsetLabel.attributedText = NSMutableAttributedString(
            string: viewModel.sunriseText,
            attributes: viewModel.sunriseLabelAttributes
        )
        sunsetLabel.font = viewModel.sunriseLabelFont

        locationLabel.textColor = Colors.textBlack.color
        locationLabel.attributedText = NSMutableAttributedString(
            string: model.location ?? "",
            attributes: Fonts.H2.install.attributes
        )
        locationLabel.font = Fonts.H2.install.font

        guard let forcastModel = model.oneDayForcastModel else { return }
        setupForcast(withDatamModel: forcastModel, andPropertiesModel: model.viewModelForcast)
    }
    ///Установка данных прогноза
    private func setupForcast(
        withDatamModel model: OneDayForcastModel,
        andPropertiesModel propertiesModel: DailyForcastModel.ViewModelForcast
    ) {

        let dayTemp = model.dayTemp ?? ""
        dayTempLabel.textColor = propertiesModel.dayTempLabelTextColor
        dayTempLabel.attributedText = NSMutableAttributedString(
            string: dayTemp,
            attributes: propertiesModel.dayTempLabelAttributes
        )
        dayTempLabel.font = propertiesModel.dayTempLabelFont

        let dayCondition = model.dayCondition ?? ""
        dayConditionLabel.textColor = propertiesModel.dayConditionLabelTextColor
        dayConditionLabel.attributedText = NSMutableAttributedString(
            string: dayCondition,
            attributes: propertiesModel.dayConditionLabelAttributes
        )
        dayConditionLabel.font = propertiesModel.dayConditionLabelFont

        dayConditionImageView.image = propertiesModel.dayConditionImage

        let dayFeelsLike = model.dayFeelsLike
        dayValueFeelsLikeLabel.textColor = propertiesModel.dayValueCloudnessLabelTextColor
        dayValueFeelsLikeLabel.attributedText = NSMutableAttributedString(
            string: dayFeelsLike ?? "",
            attributes: propertiesModel.dayValueCloudnessLabelAttributes
        )
        dayValueFeelsLikeLabel.font = propertiesModel.dayValueCloudnessLabelFont

        let dayWindSpeed = model.dayWindSpeed
        let dayWindDir = model.dayWindDirection
        dayValueWindSpeedLabel.textColor = propertiesModel.dayValueWindSpeedLabelTextColor
        dayValueWindSpeedLabel.attributedText = NSMutableAttributedString(
            string: (dayWindSpeed ?? "") + " " + (dayWindDir ?? ""),
            attributes: propertiesModel.dayValueWindSpeedLabelAttributes
        )
        dayValueWindSpeedLabel.font = propertiesModel.dayValueWindSpeedLabelFont

        var uv = ""
        if let dayUV = model.dayUVIndex {
            uv = String(dayUV)
        }
        dayValueUVIndexLabel.textColor = propertiesModel.dayValueUVIndexLabelTextColor
        dayValueUVIndexLabel.attributedText = NSMutableAttributedString(
            string: uv,
            attributes: propertiesModel.dayValueUVIndexLabelAttributes
        )
        dayValueUVIndexLabel.font = Fonts.body3.install.font

        var cloudness = ""
        if let dayCloudness = model.dayUVIndex {
            cloudness = String(dayCloudness) + "%"
        }
        dayValueCloudnessLabel.textColor = propertiesModel.dayValueCloudnessLabelTextColor
        dayValueCloudnessLabel.attributedText = NSMutableAttributedString(
            string: cloudness,
            attributes: propertiesModel.dayValueCloudnessLabelAttributes
        )
        dayValueCloudnessLabel.font = propertiesModel.dayValueCloudnessLabelFont

        let nightTemp = model.nightTemp ?? ""
        nightTempLabel.textColor = propertiesModel.nightTempLabelTextColor
        nightTempLabel.attributedText = NSMutableAttributedString(
            string: nightTemp,
            attributes: propertiesModel.nightTempLabelAttributes
        )
        nightTempLabel.font = propertiesModel.nightTempLabelFont

        let nightCondition = model.nightCondition ?? ""
        nightConditionLabel.textColor = propertiesModel.nightConditionLabelTextColor
        nightConditionLabel.attributedText = NSMutableAttributedString(
            string: nightCondition,
            attributes: propertiesModel.nightConditionLabelAttributes
        )
        nightConditionLabel.font = propertiesModel.nightConditionLabelFont

        nightConditionImageView.image = propertiesModel.nightConditionImage

        let nightFeelsLike = model.nightFeelsLike
        nightValueFeelsLikeLabel.textColor = propertiesModel.nightValueFeelsLikeLabelTextColor
        nightValueFeelsLikeLabel.attributedText = NSMutableAttributedString(
            string: nightFeelsLike ?? "",
            attributes: propertiesModel.nightValueFeelsLikeLabelAttributes
        )
        nightValueFeelsLikeLabel.font = propertiesModel.nightValueFeelsLikeLabelFont

        let nightWindSpeed = model.nightWindSpeed
        let nightWindDir = model.nightWindDirection
        nightValueWindSpeedLabel.textColor = propertiesModel.nightValueWindSpeedLabelTextColor
        nightValueWindSpeedLabel.attributedText = NSMutableAttributedString(
            string: (nightWindSpeed ?? "") + " " + (nightWindDir ?? ""),
            attributes: propertiesModel.nightValueWindSpeedLabelAttributes
        )
        nightValueWindSpeedLabel.font = propertiesModel.nightValueWindSpeedLabelFont

        var uvN = ""
        if let nightUV = model.nightUVIndex {
            uvN = String(nightUV)
        }
        nightValueUVIndexLabel.textColor = propertiesModel.nightValueUVIndexLabelTextColor
        nightValueUVIndexLabel.attributedText = NSMutableAttributedString(
            string: uvN,
            attributes: propertiesModel.nightValueUVIndexLabelAttributes
        )
        nightValueUVIndexLabel.font = propertiesModel.nightValueUVIndexLabelFont

        var cloudnessN = ""
        if let nightCloudness = model.nightUVIndex {
            cloudnessN = String(nightCloudness) + "%"
        }
        nightValueCloudnessLabel.textColor = propertiesModel.nightValueCloudnessLabelTextColor
        nightValueCloudnessLabel.attributedText = NSMutableAttributedString(
            string: cloudnessN,
            attributes: propertiesModel.nightValueCloudnessLabelAttributes
        )
        nightValueCloudnessLabel.font = propertiesModel.nightValueCloudnessLabelFont

        let sunriseTime = model.sunrise
        sunriseTimeLabel.textColor = propertiesModel.sunriseTimeLabelTextColor
        sunriseTimeLabel.attributedText = NSMutableAttributedString(
            string: sunriseTime ?? "",
            attributes: propertiesModel.sunriseTimeLabelAttributes
        )
        sunriseTimeLabel.font = propertiesModel.sunriseTimeLabelFont

        let sunsetTime = model.sunset
        sunsetTimeLabel.textColor = propertiesModel.sunsetTimeLabelTextColor
        sunsetTimeLabel.attributedText = NSMutableAttributedString(
            string: sunsetTime ?? "",
            attributes: propertiesModel.sunsetTimeLabelAttributes
        )
        sunsetTimeLabel.font = propertiesModel.sunsetTimeLabelFont

        guard let fullSunriseTime = model.sunrise else { return }
        let resultSunrise: [String] = fullSunriseTime.components(separatedBy: ":")
        guard let hursSunrise = Int(resultSunrise[0]) else { return }
        guard let minutesSunrise = Int(resultSunrise[1]) else { return }

        guard let fullSunsetTime = model.sunset else { return }
        let resultSunset: [String] = fullSunsetTime.components(separatedBy: ":")
        guard let hursSunset = Int(resultSunset[0]) else { return }
        guard let minutesSunset = Int(resultSunset[1]) else { return }

        let userCalendar = NSCalendar.current
        ///задаем первую дату
        var firstTime = DateComponents()
        firstTime.hour = hursSunset
        firstTime.minute = minutesSunset
        guard let firstDate = userCalendar.date(from: firstTime) else { return }

        ///задаем вторую дату
        var secondTime = DateComponents()
        secondTime.hour = hursSunrise
        secondTime.minute = minutesSunrise
        guard let secondDate = userCalendar.date(from: secondTime) else { return }
        ///находим разницу между первой и второй датами
        let difference = Calendar.current.dateComponents([.hour, .minute], from: secondDate, to: firstDate)

        guard let hour = difference.hour else { return }
        guard let minutes = difference.minute else { return }
        let stringHour = String(hour)
        let stringMinutes = String(minutes)

        let solarDayLength =
        stringHour + "ч" + " " + stringMinutes + " " + "мин"

        solarTimeLabel.textColor = propertiesModel.solarTimeLabelTextColor
        solarTimeLabel.attributedText = NSMutableAttributedString(
            string: solarDayLength,
            attributes: propertiesModel.solarTimeLabelAttributes
        )
        solarTimeLabel.font = propertiesModel.solarTimeLabelFont
    }
}
