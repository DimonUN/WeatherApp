//
//  OneDayForcastTableViewCell.swift
//  Weather
//
//  Created by Дмитрий Никоноров on 02.09.2022.
//

import UIKit
///Вторая секция таблицы, в которой раслопожены ячейки с прогнозом на день(7 штук)
final class OneDayForcastTableViewCell: UITableViewCell {
    // MARK: - Properties
    ///Лэйбл с датой прогноза
    private lazy var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.toAutoLayout()
        return dateLabel
    }()
    ///Картинка с прогнозом
    private lazy var weatherImageView: UIImageView = {
        let weatherImageView = UIImageView()
        weatherImageView.contentMode = .scaleAspectFill
        weatherImageView.toAutoLayout()
        return weatherImageView
    }()
    ///Лэйбл с влажностью
    private lazy var humidityLabel: UILabel = {
        let humidityLabel = UILabel()
        humidityLabel.toAutoLayout()
        return humidityLabel
    }()
    ///Лэйбл с прогнозом
    private lazy var mainForcastLabel: UILabel = {
        let mainForcastLabel = UILabel()
        mainForcastLabel.textAlignment = .left
        mainForcastLabel.numberOfLines = 2
        mainForcastLabel.toAutoLayout()
        return mainForcastLabel
    }()
    ///Лэйбл с минимаьной темпетатурой
    private lazy var temperatureFromLabel: UILabel = {
        let temperatureFromLabel = UILabel()
        temperatureFromLabel.toAutoLayout()
        return temperatureFromLabel
    }()
    ///Лэйбл с максимальной темпетатурой
    private lazy var temperatureToLabel: UILabel = {
        let temperatureToLabel = UILabel()
        temperatureToLabel.toAutoLayout()
        return temperatureToLabel
    }()
    ///Знак градуса для минимаьной темпетатуры
    private lazy var degreeIconFromView: UIView = {
        let degreeIconView = UIView()
        degreeIconView.layer.borderWidth = 1.0
        degreeIconView.layer.cornerRadius = 5.0
        degreeIconView.toAutoLayout()
        return degreeIconView
    }()
    ///Знак градуса для максимальной темпетатуры
    private lazy var degreeIconToView: UIView = {
        let degreeIconToView = UIView()
        degreeIconToView.layer.borderWidth = 1.0
        degreeIconToView.layer.cornerRadius = 5.0
        degreeIconToView.toAutoLayout()
        return degreeIconToView
    }()
    ///Картинка стрелочки next
    private lazy var nextIconImageView: UIImageView = {
        let nextIconImageView = UIImageView()
        nextIconImageView.toAutoLayout()
        return nextIconImageView
    }()
    ///Фотовая view с заливкой цветом
    private lazy var backgroundUIView: UIView = {
        let backgroundView = UIView()
        backgroundView.layer.cornerRadius = 5.0
        backgroundView.toAutoLayout()
        return backgroundView
    }()
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        contentView.addSubviews(backgroundUIView)
        backgroundUIView.addSubviews(
            dateLabel,
            weatherImageView,
            humidityLabel,
            mainForcastLabel,
            temperatureFromLabel,
            temperatureToLabel,
            degreeIconFromView,
            degreeIconToView,
            nextIconImageView
        )
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Methods
    private func setupConstraints() {
        [
            ///backgroundUIView
            backgroundUIView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 16.0
            ),
            backgroundUIView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -16.0
            ),
            backgroundUIView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 5.0
            ),
            backgroundUIView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -5.0
            ),
            ///dateLabel
            dateLabel.leadingAnchor.constraint(
                equalTo: backgroundUIView.leadingAnchor,
                constant: 10.0
            ),
            dateLabel.topAnchor.constraint(
                equalTo: backgroundUIView.topAnchor,
                constant: 6.0
            ),
            ///weatherImageView
            weatherImageView.leadingAnchor.constraint(
                equalTo: dateLabel.leadingAnchor
            ),
            weatherImageView.topAnchor.constraint(
                equalTo: dateLabel.bottomAnchor,
                constant: 6.0
            ),
            weatherImageView.centerYAnchor.constraint(
                equalTo: humidityLabel.centerYAnchor
            ),
            weatherImageView.widthAnchor.constraint(
                equalToConstant: 15.0
            ),
            weatherImageView.heightAnchor.constraint(
                equalToConstant: 15.0
            ),
            ///humidityLabel
            humidityLabel.leadingAnchor.constraint(
                equalTo: weatherImageView.trailingAnchor,
                constant: 6.0
            ),
            humidityLabel.trailingAnchor.constraint(
                equalTo: dateLabel.trailingAnchor
            ),
            humidityLabel.topAnchor.constraint(
                equalTo: dateLabel.bottomAnchor,
                constant: 6.0
            ),
            humidityLabel.bottomAnchor.constraint(
                equalTo: backgroundUIView.bottomAnchor,
                constant: -10.0
            ),
            ///mainForcastLabel
            mainForcastLabel.leadingAnchor.constraint(
                equalTo: dateLabel.trailingAnchor,
                constant: 12.0
            ),
            mainForcastLabel.centerYAnchor.constraint(
                equalTo: backgroundUIView.centerYAnchor
            ),
            mainForcastLabel.widthAnchor.constraint(
                lessThanOrEqualToConstant: 206.0
            ),
            ///nextIconImageView
            nextIconImageView.trailingAnchor.constraint(
                equalTo: backgroundUIView.trailingAnchor,
                constant: -10.0
            ),
            nextIconImageView.centerYAnchor.constraint(
                equalTo: backgroundUIView.centerYAnchor
            ),
            nextIconImageView.heightAnchor.constraint(
                equalToConstant: 10
            ),
            nextIconImageView.widthAnchor.constraint(
                equalToConstant: 10.0
            ),
            ///temperatureToLabel
            temperatureToLabel.trailingAnchor.constraint(
                equalTo: nextIconImageView.leadingAnchor,
                constant: -14.0
            ),
            temperatureToLabel.centerYAnchor.constraint(
                equalTo: backgroundUIView.centerYAnchor
            ),
            temperatureFromLabel.trailingAnchor.constraint(
                equalTo: temperatureToLabel.leadingAnchor
            ),
            temperatureFromLabel.centerYAnchor.constraint(
                equalTo: backgroundUIView.centerYAnchor
            ),
            ///degreeIconFromView
            degreeIconFromView.leadingAnchor.constraint(
                equalTo: temperatureFromLabel.trailingAnchor,
                constant: 1.0
            ),
            degreeIconFromView.heightAnchor.constraint(
                equalToConstant: 6.0
            ),
            degreeIconFromView.widthAnchor.constraint(
                equalToConstant: 6.0
            ),
            degreeIconFromView.bottomAnchor.constraint(
                equalTo: temperatureFromLabel.topAnchor,
                constant: 4.0
            ),
            ///degreeIconToView
            degreeIconToView.leadingAnchor.constraint(
                equalTo: temperatureToLabel.trailingAnchor,
                constant: 1.0
            ),
            degreeIconToView.heightAnchor.constraint(
                equalToConstant: 6.0
            ),
            degreeIconToView.widthAnchor.constraint(
                equalToConstant: 6.0
            ),
            degreeIconToView.bottomAnchor.constraint(
                equalTo: temperatureToLabel.topAnchor,
                constant: 4.0
            )
        ].forEach { $0.isActive = true }
    }
    // MARK: - Interface
    func setupCell(withModel model: MainScreenModel.OneDayForcastTableCellModel) {
        dateLabel.textColor = model.dateLabelTextColor
        dateLabel.font = model.dateLabelFont

        humidityLabel.textColor = model.humidityLabelTextColor
        humidityLabel.font = model.humidityLabelFont

        mainForcastLabel.textColor = model.mainForcastLabelTextColor
        mainForcastLabel.font = model.mainForcastLabelFont

        temperatureFromLabel.textColor = model.temperatureFromLabelTextColor
        temperatureFromLabel.font = model.temperatureFromLabelFont

        temperatureToLabel.textColor = model.temperatureToLabelTextColor
        temperatureToLabel.font = model.temperatureToLabelFont

        degreeIconFromView.layer.borderColor = model.degreeIconFromViewBorderColor.cgColor
        degreeIconToView.layer.borderColor = model.degreeIconToViewBorderColor.cgColor

        nextIconImageView.image = model.nextIconImage

        backgroundUIView.backgroundColor = model.backgroundUIViewColor
    }
    func setupForcast(
        date: String,
        humidity: String,
        mainForcast: String,
        temperatureFrom: String,
        temperatureTo: String,
        image: UIImage
    ) {
        dateLabel.attributedText = NSMutableAttributedString(
            string: date,
            attributes: Fonts.body.install.attributes
        )
        humidityLabel.attributedText = NSMutableAttributedString(
            string: humidity,
            attributes: Fonts.caption.install.attributes
        )
        mainForcastLabel.attributedText = NSMutableAttributedString(
            string: mainForcast,
            attributes: Fonts.body.install.attributes
        )
        temperatureFromLabel.attributedText = NSMutableAttributedString(
            string: temperatureFrom,
            attributes: Fonts.H3.install.attributes
        )
        temperatureToLabel.attributedText = NSMutableAttributedString(
            string: "..." + temperatureTo,
            attributes: Fonts.H3.install.attributes
        )
        weatherImageView.image = image
    }
}
