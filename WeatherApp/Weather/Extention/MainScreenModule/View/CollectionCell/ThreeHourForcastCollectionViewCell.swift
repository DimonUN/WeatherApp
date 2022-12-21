//
//  ThreeHourForcastCollectionViewCell.swift
//  Weather
//
//  Created by Дмитрий Никоноров on 02.09.2022.
//

import UIKit
///Ячейка коллекции с прогнозом на 3 часа
final class ThreeHourForcastCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    ///Лэйбл с временем
    private var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.numberOfLines = 1
        timeLabel.textAlignment = .center
        timeLabel.toAutoLayout()
        return timeLabel
    }()
    ///Картинка с погодой
    private lazy var weatherImageView: UIImageView = {
        let weatherImageView = UIImageView()
        weatherImageView.contentMode = .scaleAspectFit
        weatherImageView.toAutoLayout()
        return weatherImageView
    }()
    ///Лэйбл с температурой
    private lazy var temperatureLabel: UILabel = {
        let temperatureLabel = UILabel()
        temperatureLabel.toAutoLayout()
        return temperatureLabel
    }()
    ///Знак градуса для лэйбла с температурой
    private lazy var degreeView: UIView = {
        let degreeView = UIView()
        degreeView.layer.borderWidth = 1.0
        degreeView.layer.cornerRadius = 5.0
        degreeView.contentMode = .scaleAspectFit
        degreeView.toAutoLayout()
        return degreeView
    }()
    // MARK: - Methods
    ///Настройка UI
    private func setupUI() {
        contentView.addSubviews(timeLabel, weatherImageView, temperatureLabel, degreeView)
        contentView.layer.cornerRadius = 22.0
        contentView.layer.borderWidth = 1.0
    }
    ///Настройка констрейнтов
    private func setupConstraints() {
        [
            ///timeLabel
            timeLabel.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 15.0
            ),
            timeLabel.centerXAnchor.constraint(
                equalTo: contentView.centerXAnchor
            ),
            ///weatherImageView
            weatherImageView.topAnchor.constraint(
                equalTo: timeLabel.bottomAnchor,
                constant: 6.0
            ),
            weatherImageView.centerXAnchor.constraint(
                equalTo: contentView.centerXAnchor
            ),
            weatherImageView.widthAnchor.constraint(
                equalToConstant: 24.0
            ),
            weatherImageView.heightAnchor.constraint(
                equalToConstant: 24.0
            ),
            ///temperatureLabel
            temperatureLabel.topAnchor.constraint(
                equalTo: weatherImageView.bottomAnchor,
                constant: 6.0
            ),
            temperatureLabel.centerXAnchor.constraint(
                equalTo: contentView.centerXAnchor,
                constant: -2.0
            ),
            temperatureLabel.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -6.0
            ),
            ///degreeView
            degreeView.leadingAnchor.constraint(
                equalTo: temperatureLabel.trailingAnchor,
                constant: 1.0
            ),
            degreeView.bottomAnchor.constraint(
                equalTo: temperatureLabel.topAnchor,
                constant: 4.0
            ),
            degreeView.heightAnchor.constraint(
                equalToConstant: 6.0
            ),
            degreeView.widthAnchor.constraint(
                equalToConstant: 6.0
            )
        ].forEach { $0.isActive = true }
    }
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Interface
    func setupCell(withModel model: MainScreenModel.ThreeHourCollectionCellModel) {
        timeLabel.textColor = model.timeLabelTextColor
        timeLabel.font = model.timeLabelFont
        weatherImageView.image = model.weatherImage
        temperatureLabel.textColor = model.temperatureLabelTextColor
        temperatureLabel.font = model.temperatureLabelFont
        degreeView.layer.borderColor = model.degreeViewBorderColor.cgColor
        contentView.layer.borderColor = model.degreeViewBorderColor.cgColor
    }
    func setupForcast(time: String, weatherImage: UIImage, temperature: String) {
        timeLabel.attributedText = NSMutableAttributedString(
            string: time,
            attributes: Fonts.body3.install.attributes
        )
        weatherImageView.image = weatherImage
        temperatureLabel.attributedText = NSMutableAttributedString(
            string: temperature,
            attributes: Fonts.body.install.attributes
        )
    }
}
